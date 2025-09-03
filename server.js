const express = require('express');
const ejs = require('ejs');
const mysql = require('mysql2');
const jwt = require('jsonwebtoken');
const multer = require('multer');
const dotenv = require('dotenv');
const { OpenAI } = require('openai');
const path = require('path');
const cookieParser = require('cookie-parser');

dotenv.config();

const app = express();
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views')); // Ensure views directory is set
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(express.static('public'));
app.use(cookieParser());

// Koneksi Database
const db = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME
});

db.connect(err => {
    if (err) {
        console.error('Failed to connect to MySQL:', err);
        throw err;
    }
    console.log('MySQL Connected...');
});

// Multer untuk upload gambar
const storage = multer.diskStorage({
    destination: (req, file, cb) => cb(null, 'public/uploads'),
    filename: (req, file, cb) => cb(null, Date.now() + '-' + file.originalname)
});
const upload = multer({ storage });

// Middleware Auth JWT
const authMiddleware = (req, res, next) => {
    let token = req.headers.authorization?.split(' ')[1];
    if (!token && req.cookies?.token) {
        token = req.cookies.token;
    }
    if (!token) {
        return res.status(401).json({ message: 'Unauthorized' });
    }
    jwt.verify(token, process.env.JWT_SECRET, (err, user) => {
        if (err) {
            return res.status(403).json({ message: 'Forbidden' });
        }
        req.user = user;
        next();
    });
};

// Middleware Admin Only
const adminMiddleware = (req, res, next) => {
    console.log('Admin Middleware - User role:', req.user.role);
    if (req.user.role !== 'admin') {
        console.log('Admin Middleware - Access denied, not admin');
        return res.status(403).json({ message: 'Admin only' });
    }
    next();
};

// Client AI Hugging Face
const client = new OpenAI({
    baseURL: "https://router.huggingface.co/v1",
    apiKey: process.env.HF_TOKEN,
});

// Route untuk halaman login admin
app.get('/admin/login', (req, res) => {
    res.clearCookie('token');
    res.render('admin_login');
});

// Route untuk halaman chatbot
app.get('/chatbot', (req, res) => {
    db.query('SELECT * FROM categories', (err, categories) => {
        if (err) {
            console.error('Error fetching categories for chatbot:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        try {
            res.render('chatbot', { categories });
        } catch (err) {
            console.error('Error rendering chatbot.ejs:', err);
            res.status(500).json({ message: 'Error rendering chatbot page' });
        }
    });
});

// Routes Utama
app.get('/', (req, res) => {
    db.query('SELECT * FROM articles ORDER BY created_at DESC', (err, articles) => {
        if (err) {
            console.error('Error fetching articles:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        db.query('SELECT * FROM categories', (err, categories) => {
            if (err) {
                console.error('Error fetching categories:', err);
                return res.status(500).json({ message: 'Server error' });
            }
            res.render('index', { articles, categories });
        });
    });
});

// Pencarian Artikel
app.get('/search', (req, res) => {
    const { query, category } = req.query;
    let sql = 'SELECT * FROM articles WHERE 1=1';
    if (query) sql += ` AND title LIKE '%${query}%'`;
    if (category) sql += ` AND category_id = ${category}`;
    db.query(sql, (err, articles) => {
        if (err) {
            console.error('Error searching articles:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        db.query('SELECT * FROM categories', (err, categories) => {
            if (err) {
                console.error('Error fetching categories:', err);
                return res.status(500).json({ message: 'Server error' });
            }
            res.render('index', { articles, categories });
        });
    });
});

// Detail Artikel
app.get('/article/:id', (req, res) => {
    db.query('UPDATE articles SET view_count = view_count + 1 WHERE id = ?', [req.params.id]);
    db.query('SELECT * FROM articles WHERE id = ?', [req.params.id], (err, [article]) => {
        if (err) {
            console.error('Error fetching article:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        db.query('SELECT * FROM categories', (err, categories) => {
            if (err) {
                console.error('Error fetching categories:', err);
                return res.status(500).json({ message: 'Server error' });
            }
            res.render('article', { article, categories });
        });
    });
});

// Register User
app.post('/register', (req, res) => {
    const { username, password, email } = req.body;
    if (!username || !password || !email) {
        return res.status(400).json({ message: 'Semua field diperlukan' });
    }
    
    db.query('INSERT INTO users (username, password, email) VALUES (?, ?, ?)', [username, password, email], (err) => {
        if (err) {
            console.error('Register error:', err);
            return res.status(500).json({ message: 'Error registering user' });
        }
        res.json({ message: 'Registered' });
    });
});

// Login User
app.post('/login', (req, res) => {
    console.log('Login request body:', req.body);
    const { email, password } = req.body;
    if (!email || !password) {
        return res.status(400).json({ message: 'Email dan password diperlukan' });
    }
    
    db.query('SELECT * FROM users WHERE email = ?', [email], (err, results) => {
        if (err) {
            console.error('Database error:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        console.log('Query results:', results);
        if (results.length === 0) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }
        
        const user = results[0];
        if (user.password !== password) {
            return res.status(401).json({ message: 'Invalid credentials' });
        }
        if (user.role === 'admin') {
            return res.status(403).json({ message: 'Gunakan login admin' });
        }
        
        const token = jwt.sign({ id: user.id, role: user.role }, process.env.JWT_SECRET);
        res.json({ token });
    });
});

// Login Admin
app.post('/admin/login', (req, res) => {
    const { email, password } = req.body;
    if (!email || !password) {
        return res.status(400).json({ message: 'Email dan password diperlukan' });
    }

    db.query('SELECT * FROM users WHERE email = ? AND role = "admin"', [email], (err, results) => {
        if (err) return res.status(500).json({ message: 'Server error' });
        if (results.length === 0) return res.status(401).json({ message: 'Invalid admin credentials' });

        const admin = results[0];
        if (admin.password !== password) return res.status(401).json({ message: 'Invalid credentials' });

        const token = jwt.sign({ id: admin.id, role: admin.role }, process.env.JWT_SECRET);
        res.cookie('token', token, { httpOnly: true });
        res.json({ token });
    });
});

// Dashboard User
app.get('/dashboard', authMiddleware, (req, res) => {
    db.query('SELECT * FROM chat_history WHERE user_id = 1 ORDER BY created_at DESC', [req.user.id], (err, chats) => {
        if (err) {
            console.error('Error fetching chat history:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        db.query('SELECT a.* FROM articles a JOIN favorites f ON a.id = f.article_id WHERE f.user_id = ?', [req.user.id], (err, favorites) => {
            if (err) {
                console.error('Error fetching favorites:', err);
                return res.status(500).json({ message: 'Server error' });
            }
            res.render('user_dashboard', { chats, favorites });
        });
    });
});

// Tambah Favorit
app.post('/favorite/:articleId', authMiddleware, (req, res) => {
    db.query('INSERT INTO favorites (user_id, article_id) VALUES (?, ?)', [req.user.id, req.params.articleId], (err) => {
        if (err) {
            console.error('Error adding favorite:', err);
            return res.status(500).json({ message: 'Error' });
        }
        res.json({ message: 'Favorited' });
    });
});

// POST /chat → kirim pertanyaan & simpan ke chat_history
// POST /chat → kirim pertanyaan & simpan ke chat_history
app.post('/chat', (req, res) => {
    const { message } = req.body;
    if (!message) return res.status(400).json({ message: 'Message required' });

    try {
        db.query(
            'SELECT title, content, article_references FROM articles WHERE content LIKE ? OR title LIKE ? LIMIT 3',
            [`%${message}%`, `%${message}%`],
            async (err, articles) => {
                if (err) {
                    console.error('Error searching articles for RAG:', err);
                    return res.status(500).json({ message: 'Server error' });
                }

                if (articles.length === 0) {
                    const aiReply = 'Maaf, saya hanya bisa menjawab pertanyaan tentang kesehatan.';
                    db.query(
                        'INSERT INTO chat_history (message, reply, created_at) VALUES (?, ?, NOW())',
                        [message, aiReply],
                        (err) => {
                            if (err) console.error('Error saving chat history:', err);
                        }
                    );
                    return res.json({ reply: aiReply });
                }

                let context = '';
                articles.forEach((art) => {
                    context += `Artikel: ${art.title}\nIsi: ${art.content}\nReferensi: ${art.article_references}\n\n`;
                });

                const prompt = `Anda adalah chatbot spesialis kesehatan. Jawab pertanyaan berikut hanya berdasarkan konteks kesehatan yang diberikan. Jika pertanyaan di luar kesehatan atau tidak relevan dengan konteks, jawab: "Maaf, saya hanya bisa menjawab pertanyaan tentang kesehatan." Konteks: \n${context}\nPertanyaan: ${message}`;

                try {
                    const responseAI = await client.chat.completions.create({
                        model: "openai/gpt-oss-120b:fireworks-ai",
                        messages: [{ role: "user", content: prompt }],
                    });

                    const aiReply = responseAI.choices[0].message.content;

                    db.query(
                        'INSERT INTO chat_history (message, reply, created_at) VALUES (?, ?, NOW())',
                        [message, aiReply],
                        (err) => {
                            if (err) console.error('Error saving chat history:', err);
                        }
                    );

                    res.json({ reply: aiReply });
                } catch (err) {
                    console.error('AI Error:', err);
                    res.status(500).json({ message: 'AI Error' });
                }
            }
        );
    } catch (err) {
        console.error('Server Error:', err);
        res.status(500).json({ message: 'Server error' });
    }
});


// Dashboard Admin
app.get('/admin/dashboard', authMiddleware, adminMiddleware, (req, res) => {
    console.log('Rendering admin dashboard for user:', req.user);
    db.query('SELECT * FROM articles ORDER BY view_count DESC LIMIT 5', (err, popularArticles) => {
        if (err) {
            console.error('Error fetching popular articles:', err);
            return res.status(500).json({ message: 'Server error' });
        }

        // ✅ Hanya ambil pertanyaan dari user
        db.query(
            'SELECT message, COUNT(*) as count FROM chat_history WHERE sender = "user" GROUP BY message ORDER BY count DESC LIMIT 5',
            (err, popularQuestions) => {
                if (err) {
                    console.error('Error fetching popular questions:', err);
                    return res.status(500).json({ message: 'Server error' });
                }

                db.query('SELECT * FROM categories', (err, categories) => {
                    if (err) {
                        console.error('Error fetching categories:', err);
                        return res.status(500).json({ message: 'Server error' });
                    }
                    res.render('admin_dashboard', { popularArticles, popularQuestions, categories });
                });
            }
        );
    });
});


// CRUD Artikel
app.get('/admin/articles', authMiddleware, adminMiddleware, (req, res) => {
    db.query('SELECT a.*, c.name as category FROM articles a LEFT JOIN categories c ON a.category_id = c.id', (err, articles) => {
        if (err) {
            console.error('Error fetching articles:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        db.query('SELECT * FROM categories', (err, categories) => {
            if (err) {
                console.error('Error fetching categories:', err);
                return res.status(500).json({ message: 'Server error' });
            }
            res.render('admin_articles', { articles, categories });
        });
    });
});

app.get('/admin/articles/add', authMiddleware, adminMiddleware, (req, res) => {
    db.query('SELECT * FROM categories', (err, categories) => {
        if (err) {
            console.error('Error fetching categories:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        res.render('admin_article_add', { categories });
    });
});

app.post('/admin/article', authMiddleware, adminMiddleware, upload.single('image'), (req, res) => {
    const { title, content, category_id, article_references } = req.body;
    const image_url = req.file ? `/uploads/${req.file.filename}` : null;
    db.query('INSERT INTO articles (title, content, category_id, image_url, article_references) VALUES (?, ?, ?, ?, ?)', 
        [title, content, category_id, image_url, article_references], (err) => {
            if (err) {
                console.error('Error adding article:', err);
                return res.status(500).json({ message: 'Server error' });
            }
            res.redirect('/admin/articles');
        });
});

app.post('/admin/article/:id/update', authMiddleware, adminMiddleware, upload.single('image'), (req, res) => {
    const { title, content, category_id, article_references } = req.body;
    let sql = 'UPDATE articles SET title=?, content=?, category_id=?, article_references=?';
    const params = [title, content, category_id, article_references];
    if (req.file) {
        sql += ', image_url=?';
        params.push(`/uploads/${req.file.filename}`);
    }
    sql += ' WHERE id=?';
    params.push(req.params.id);
    db.query(sql, params, (err) => {
        if (err) {
            console.error('Error updating article:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        res.redirect('/admin/articles');
    });
});

app.post('/admin/article/:id/delete', authMiddleware, adminMiddleware, (req, res) => {
    db.query('DELETE FROM articles WHERE id=?', [req.params.id], (err) => {
        if (err) {
            console.error('Error deleting article:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        res.redirect('/admin/articles');
    });
});

// CRUD Kategori
app.post('/admin/category', authMiddleware, adminMiddleware, (req, res) => {
    const { name, description } = req.body;
    console.log('Add category request:', { name, description });
    db.query('INSERT INTO categories (name, description) VALUES (?, ?)', [name, description], (err) => {
        if (err) {
            console.error('Error adding category:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        res.redirect('/admin/dashboard');
    });
});

app.post('/admin/category/:id/delete', authMiddleware, adminMiddleware, (req, res) => {
    const categoryId = req.params.id;
    console.log('Delete category request for ID:', categoryId);
    db.query('DELETE FROM categories WHERE id=?', [categoryId], (err) => {
        if (err) {
            console.error('Error deleting category:', err);
            return res.status(500).json({ message: 'Server error' });
        }
        res.redirect('/admin/dashboard');
    });
});

// Jalankan Server
app.listen(process.env.PORT, () => {
    console.log(`Server running on port ${process.env.PORT}`);
});
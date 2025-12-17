import React, { useState } from 'react';
import { motion } from 'framer-motion';
import { LogIn, Mail, Lock } from 'lucide-react';

const LoginPage: React.FC = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);

    const handleLogin = async (e: React.FormEvent) => {
        e.preventDefault();
        setError(null);

        if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
            setError('Please enter a valid email');
            return;
        }

        setLoading(true);

        try {
            const response = await fetch(`${(import.meta as any).env?.VITE_API_BASE_URL || 'http://localhost:8002'}/api/v1/auth/login`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email, password }),
            });

            const data = await response.json();

            if (!response.ok) {
                setError(data.detail || 'Login failed');
                setLoading(false);
                return;
            }

            // Store tokens
            if (data.access_token) {
                localStorage.setItem('access_token', data.access_token);
            }
            if (data.refresh_token) {
                localStorage.setItem('refresh_token', data.refresh_token);
            }
            localStorage.setItem('userEmail', email);

            // Redirect to dashboard
            window.location.href = '/dashboard';
        } catch (err) {
            setError('Network error. Please try again.');
            setLoading(false);
        }
    };

    return (
        <div className="min-h-screen bg-[#0a0a0a] text-slate-50 flex items-center justify-center">
            <div className="w-full max-w-md px-4">
                <motion.div initial={{ opacity: 0, y: 16 }} animate={{ opacity: 1, y: 0 }}>
                    <div className="text-center mb-8">
                        <h1 className="text-3xl font-extrabold text-white mb-2">Welcome Back</h1>
                        <p className="text-slate-400">Sign in to your InboxGrove account</p>
                    </div>

                    <form onSubmit={handleLogin} className="bg-slate-900/60 border border-slate-800 rounded-xl p-6 space-y-5">
                        {error && (
                            <div className="rounded-lg border border-red-500/30 bg-red-500/10 text-red-200 px-4 py-3 text-sm">
                                {error}
                            </div>
                        )}

                        <div>
                            <label className="block text-sm font-semibold text-slate-300 mb-2">
                                <Mail size={16} className="inline mr-2" />
                                Email
                            </label>
                            <input
                                type="email"
                                required
                                value={email}
                                onChange={(e) => setEmail(e.target.value)}
                                placeholder="you@company.com"
                                className="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-white placeholder-slate-600 focus:outline-none focus:ring-2 focus:ring-purple-500/60"
                            />
                        </div>

                        <div>
                            <label className="block text-sm font-semibold text-slate-300 mb-2">
                                <Lock size={16} className="inline mr-2" />
                                Password
                            </label>
                            <input
                                type="password"
                                required
                                value={password}
                                onChange={(e) => setPassword(e.target.value)}
                                placeholder="••••••••"
                                className="w-full bg-slate-950 border border-slate-800 rounded-lg px-4 py-3 text-white placeholder-slate-600 focus:outline-none focus:ring-2 focus:ring-purple-500/60"
                            />
                        </div>

                        <button
                            type="submit"
                            disabled={loading}
                            className="w-full py-3 rounded-lg font-bold text-white bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-500 hover:to-blue-500 shadow-lg shadow-purple-500/30 flex items-center justify-center gap-2 disabled:opacity-60"
                        >
                            <LogIn size={18} />
                            {loading ? 'Signing in...' : 'Sign In'}
                        </button>

                        <div className="text-center space-y-3">
                            <a href="/forgot-password" className="text-sm text-purple-400 hover:text-purple-300">
                                Forgot password?
                            </a>
                            <div className="text-sm text-slate-400">
                                Don't have an account?{' '}
                                <a href="/trial" className="text-purple-400 hover:text-purple-300 font-medium">
                                    Start free trial
                                </a>
                            </div>
                        </div>
                    </form>
                </motion.div>
            </div>
        </div>
    );
};

export default LoginPage;

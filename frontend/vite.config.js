import { defineConfig } from 'vite'

export default defineConfig({
  root: './src',
  publicDir: '../public', // adjust path relative to root
  server: {
    port: 5173
  }
})


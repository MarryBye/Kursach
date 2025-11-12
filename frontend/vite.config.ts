import { defineConfig } from 'vite';

export default defineConfig({
  root: './',
  build: {
    outDir: '../src/static',
    emptyOutDir: true,
    rollupOptions: {
      input: {
        main: './src/scripts/index.ts',
        styles: './src/styles/style.scss',
      },
      output: {
        entryFileNames: 'scripts/main.js',
        chunkFileNames: 'scripts/[name].js',
        assetFileNames: 'styles/[name][extname]'
      },
    },
  },
});
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
  plugins: [react(
    {
      include: ["**/*.mjs"]
    }
  )], // Activation du plugin React
  server: {
    port: 3000, // Port sur lequel le serveur s'exécute
  },
})

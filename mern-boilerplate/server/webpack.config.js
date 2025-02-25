const path = require('path');
const nodeExternals = require('webpack-node-externals');
const CopyPlugin = require('copy-webpack-plugin');

module.exports = {
  target: 'node',
  entry: {
    app: ['./app.js']
  },
  output: {
    path: path.resolve(__dirname, '../../production/build'),
    filename: 'app.js'
  },
  externals: [nodeExternals()],
  plugins: [
    new CopyPlugin([
      {
        from: './package.json',
        to: '../build/package.json'
      },
      {
        from: './.env/production.config.env',
        to: '../build/.env/production.config.env'
      },
      {
        from: '../client/build',
        to: '../build/client'
      }
    ])
  ]
};

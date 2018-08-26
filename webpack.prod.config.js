const ExtractTextPlugin = require('extract-text-webpack-plugin');
const VueLoaderPlugin = require('vue-loader/lib/plugin');
const WebpackNotifierPlugin = require('webpack-notifier');
const path = require('path');

const config = {
  mode: 'production',
  useSourceMap: false,
}

module.exports = {
  mode: config.mode,
  context: path.join(__dirname, 'app/assets/src'),
  entry: './application.js',
  output: {
    path: path.join(__dirname, 'app/assets'),
    filename: 'javascripts/bundle.js'
  },
  module: {
    rules: [
    {
      test: /\.scss$/,
      use: ExtractTextPlugin.extract({
        use: [
        {
          loader: 'css-loader',
          options: {
            sourceMap: config.useSourceMap,
            importLoaders: 2
          },
        },
        {
          loader: 'postcss-loader',
          options: {
            sourceMap: config.useSourceMap,
            plugins: [
            require('autoprefixer')({grid: true})
            ]
          },
        },
        {
          loader: 'sass-loader',
          options: {
            sourceMap: config.useSourceMap,
          }
        }
        ]
      }),
    },
    {
      test: /\.(png|jpg|gif|svg)$/,
      use: [
      {
        loader: 'url-loader',
        options: {
          name: '[path][name].[ext]',
          outputPath: '',
          publicPath: '../',
          limit: 1048576,
        }
      }
      ]
    },
    {
      test: /\.js$/,
      use: [
      {
        loader: 'babel-loader',
        options: {
          presets: [
          ['env', {'modules': false}]
          ]
        }
      }
      ]
    },
    {
      test: /\.vue$/,
      use: [
      {
        loader: 'vue-loader',
      }
      ]
    }
    ]
  },
  plugins: [
  new ExtractTextPlugin('stylesheets/bundle.css'),
  new VueLoaderPlugin(),
  new WebpackNotifierPlugin(),
  ],
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.common.js'
    }
  },
};

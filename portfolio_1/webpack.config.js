const path = require('path');
const glob = require('glob');
const { CleanWebpackPlugin } = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
    entry: {
        main: ['./assets/js/main.js', ...getImages()]
    },
    output: {
        filename: 'assets/js/bundle.[contenthash].js',
        path: path.resolve(__dirname, 'public')
    },
    module: {
        rules: [
            {
                test: /\.css$/,
                use: [
                    MiniCssExtractPlugin.loader,
                    "css-loader"
                ]
            },
            {
                test: /\.(png|jpe?g|gif|svg)$/,
                loader: 'file-loader',
                options: {
                    name: '[name].[ext]',
                    outputPath: 'assets/img/'
                }
            },
        ]
    },
    plugins: [
        new CleanWebpackPlugin(),
        new HtmlWebpackPlugin({
            filename: 'index.html',
            template: './index.html',
            favicon: './favicon.ico'
        }),
        new MiniCssExtractPlugin({
            filename: './assets/css/main.[contenthash].css'
        }),
        new CopyWebpackPlugin({
            patterns: [
                { from: './php/', to: 'php' },
                { from: '.htaccess', to: './' },
                { from: 'composer.json', to: './' },
            ]
        })
    ]
}

function getImages() {
    return glob.sync('./assets/img/**/*.+(png|jpg|jpeg|gif|svg)').map(image => path.resolve(__dirname, image));
}
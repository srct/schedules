const path = require('path');
const webpack = require('webpack');
const CleanWebpackPlugin = require('clean-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const HtmlWebpackPluginConfig = new HtmlWebpackPlugin({
    template: './index.html',
    filename: 'index.html',
    inject: 'body',
    favicon: 'favicon.ico',
});

module.exports = {
    mode: 'development',
    devtool: 'source-map',

    entry: './src/index.tsx',

    output: {
        filename: '[name].[hash].js',
        path: path.resolve(__dirname, 'dist'),
    },

    resolve: {
        extensions: ['.js', '.json', '.ts', '.tsx'],
    },

    module: {
        rules: [{
                test: /\.tsx?$/,
                loader: 'awesome-typescript-loader',
                exclude: /node_modules/,
            },
            {
                enforce: 'pre',
                test: /\.js$/,
                loader: 'source-map-loader',
            },
            {
                test: /\.css$/,
                use: [{
                        loader: 'style-loader',
                    },
                    {
                        loader: 'css-loader',
                    },
                ],
            },
            {
                test: /\.(js)$/,
                exclude: /(node_modules)/,
                loader: 'babel-loader',
            },
        ],
    },

    plugins: [new webpack.HotModuleReplacementPlugin(), new CleanWebpackPlugin(['dist']), HtmlWebpackPluginConfig],

    devServer: {
        contentBase: path.resolve(__dirname, 'dist'),
        compress: true,
        host: '0.0.0.0',
        port: 8080,
        hot: true,
        publicPath: '/',
        historyApiFallback: true,
    },
};

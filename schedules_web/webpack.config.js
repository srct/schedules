const path = require('path');
const webpack = require('webpack');
const CleanWebpackPlugin = require("clean-webpack-plugin");
const HtmlWebpackPlugin = require("html-webpack-plugin");

const HtmlWebpackPluginConfig = new HtmlWebpackPlugin({
    template: "./index.html",
    filename: "index.html",
    inject: "body"
});


module.exports = {
    mode: "development",
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
                loader: 'source-map-loader'
            },
        ],
    },

    plugins: [
        new webpack.HotModuleReplacementPlugin(),
        new CleanWebpackPlugin(["dist"]),
        HtmlWebpackPluginConfig
    ],

    devServer: {
        contentBase: path.resolve(__dirname, "dist"),
        compress: true,
        port: 8080,
        hot: true,
        publicPath: "/",
        historyApiFallback: true
    }
};

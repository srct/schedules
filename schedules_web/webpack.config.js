const path = require('path');
const webpack = require('webpack');

module.exports = {
    entry: './src/index.tsx',
    output: {
        filename: 'bundle.js',
        path: path.resolve(__dirname, 'dist'),
    },

    devtool: 'source-map',

    resolve: {
        extensions: ['.ts', '.tsx', '.js', '.json'],
    },

    module: {
        rules: [
            {
                test: /\.tsx?$/,
                loader: 'awesome-typescript-loader',
                exclude: /node_modules/,
            },
            { enforce: 'pre', test: /\.js$/, loader: 'source-map-loader' },
        ],
    },

    plugins: [new webpack.HotModuleReplacementPlugin()],

    devServer: {
        compress: true,
        hot: true,
        publicPath: '/dist/',
    },

    externals: {
        react: 'React',
        'react-dom': 'ReactDOM',
    },

    mode: 'development',
};

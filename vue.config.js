const { defineConfig } = require('@vue/cli-service')
const NodePolyfillPlugin = require('node-polyfill-webpack-plugin')
//const LodashModuleReplacementPlugin = require("lodash-webpack-plugin");
const { ProvidePlugin } = require('webpack')

module.exports = defineConfig({
  //parallel:false,//建構正式環境 關閉thread loader
  transpileDependencies: true,

  // chainWebpack(config) {
  //   // set worker-loader
  //   config.module
  //     .rule('worker')
  //     .test(/\.worker\.js$/)
  //     .use('worker-loader')
  //     .loader('worker-loader')
  //     .end();
  //   // .options({ inline: 'fallback' }) // 这个配置是个坑，不要加
  //   // 解决：worker 热更新问题
  //   //config.module.rule('js').exclude.add(/\.worker\.js$/);
  // },
  configureWebpack: {
    // module:{
    //   rules: [
    //     {
    //       test: /\.worker\.js$/,
    //       use: { loader: "worker-loader" },
    //     },
    //   ],
    // },
    resolve: {
      fallback: {
        buffer: require.resolve('buffer/')
        //"fs":false,
        //"path": require.resolve("path"),
        //"os": require.resolve("os-browserify/browser"),
        //"electron":require.resolve("electron"),
        //"jquery":require.resolve("jquery"),
        // "ffi-napi":require.resolve("ffi-napi"),
        // "ref-napi":require.resolve("ref-napi"),
        // "ref-array-napi":require.resolve("ref-array-napi"),
        // "ref-struct-napi":require.resolve("ref-struct-napi"),
      }
    },
    plugins: [
      new NodePolyfillPlugin(),
      new ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        'windows.jQuery': 'jquery'
      }),
      new ProvidePlugin({
        _: 'lodash',
        lodash: 'lodash'
      }),
      new ProvidePlugin({
        Buffer: ['buffer', 'Buffer'] // ['包名', '包中的值']
      })
    ]

    // Webpack 配置被应用与 web 构建 和 electron 渲染进程
  },
  // chainWebpack: (config) => {
  //   config.plugin("loadshReplace").use(new LodashModuleReplacementPlugin());
  // },
  pluginOptions: {
    electronBuilder: {
      //preload: './public/preload.js',
      nodeIntegration: true,
      //因为这两个模块中包含原生 C代码，所以要在运行的时候再获取，而不是被webpack打包到bundle中
      externals: ['ffi-napi', 'ref-napi', 'ref-array-napi', 'ref-struct-napi'],
      builderOptions: {
        extraResources: {
          // 拷贝静态文件到指定位置,否则打包之后出现找不到资源的问题.将整个resources目录拷贝到 发布的根目录下
          from: 'resources/',
          to: './'
        }
      }
    },
    i18n: {
      locale: 'y',
      fallbackLocale: 'y',
      localeDir: 'locales',
      enableLegacy: true,
      runtimeOnly: false,
      compositionOnly: true,
      fullInstall: true
    }
  }
})

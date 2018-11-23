var through = require('through2');    // npm install --save through2
var ReactDOM = require('react-dom/server');
var React = require('react');

module.exports = function(Component, props) {
  return through.obj(function(file, encoding, callback) {
    if (file.isStream()) {
      let error = new gutil.PluginError('myPlugin', 'Streaming not supported');
      return callback(error);
    }


    let contents = file.contents.toString("utf8");

    let output = ReactDOM.renderToString(React.createElement(
      Component,
      { dangerouslySetInnerHTML: { __html: contents }},
      null
    ));

    file.contents = new Buffer(output);

    callback(null, file);
  });
};

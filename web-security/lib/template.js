import React from 'react';

const Template = (props) => {
  return (
    <html>
      <head>
        <link rel="stylesheet" href="lib/style.css" />
      </head>
      <body dangerouslySetInnerHTML={{ __html: props.dangerouslySetInnerHTML.__html }}>
        { props.children }
      </body>
    </html>
  );
}

export default Template

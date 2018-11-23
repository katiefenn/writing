## Cross site scripting: Someone else's code running on your website
In 2005, Samy Kamkar became famous for [having lots of friends](https://samy.pl/myspace/). Lots and lots of friends.

Samy enjoyed using MySpace which, at the time, was the world's largest social network. Social networks at that time were more limited than today. For instance, MySpace let you upload photos to your photo gallery, but capped the limit at twelve. Twelve photos. At least you didn't have to wade through photos of avocado toast back then...

Samy discovered that MySpace also locked down the kinds of content that you could post on your MySpace page. He discovered he could inject `<img />` and `<div />` tags into his headline, but `<script />` was filtered. MySpace wasn't about to let someone else run their own code on MySpace.

Intrigued, Samy set about finding out exactly what he could do with `<img />` and `<div />` tags. He found that you could add style properties to `<div />` tags to style them with CSS.

```
<div style="background:url('javascript:alert(1)')">
```

This code only worked in Internet Explorer and in some versions of Safari, but that was plenty of people to befriend. However, MySpace was prepared for this: they also filtered the word `javascript` from `<div />`.

```
<div style="background:url('java
script:alert(1)')">
```

Samy discovered that by inserting a line break into his code, MySpace would not filter out the word _javascript_. The browser would continue to run the code _just fine_! Samy had now broken past MySpace's first line of defence and was able to start running code on his profile page. Now he started looking at _what he could do with that code_.

```
alert(document.body.innerHTML)
```

Samy wondered if he could inspect the page's source to find the details of other MySpace users to befriend. To do this, you would normally use `document.body.innerHTML`, but MySpace had filtered this too.

```
alert(eval('document.body.inne' + 'rHTML'))
```

This isn't a problem if you build up JavaScript code inside a string and execute it using the `eval()` function. This trick also worked with `XMLHttpRequest.onReadyStateChange`, which allowed Samy to send friend requests to the MySpace API and install the JavaScript code on his new friends' pages.

One final obstacle stood in his way. The [same origin policy](https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy) is a security mechanism that prevents scripts hosted on one domain interacting with sites hosted on another domain.

```
if (location.hostname == 'profile.myspace.com') {
  document.location = 'http://www.myspace.com'
  + location.pathname + location.search
}
```

Samy discovered that only the `http://www.myspace.com` domain would accept his API requests, and requests from `http://profile.myspace.com` were being blocked by the browser's same-origin policy. By redirecting the browser to `http://www.myspace.com`, he discovered that he could load profile pages _and successfully make requests to MySpace's API_. Samy installed this code on his profile page, and he waited.

![Samy's MySpace page](./img/myspace.png)

Over the course of the next day, over a million people unwittingly installed Samy's code into their MySpace profile pages and invited their friends. The load of friend requests on MySpace was so large that the site buckled and shut down. It took them two hours to remove Samy's code and patch the security holes he exploited. Samy was raided by the United States secret service and sentenced to do 90 days of community service.

This is the power of installing a little bit of JavaScript on someone else's website. It is called [cross site scripting](https://www.owasp.org/index.php/Cross-site_Scripting_(XSS)), and its effects can be devastating. It is suspected that cross-site scripting was to blame for the [2018 British Airways breach](https://www.wired.com/story/british-airways-hack-details/) that leaked the credit card details of 380,000 people.

So how can you help protect yourself from cross-site scripting?

Always sanitise user input when it comes in, using a library such as [sanitize-html](https://www.npmjs.com/package/sanitize-html). Open source tools like this benefit from hundreds of hours of work from dozens of experienced contributors. Don't be tempted to roll your own protection. MySpace was prepared, but they were not prepared enough. It makes no sense to turn this kind of help down.

You can also use an auto-escaping templating language to make sure nobody else's HTML can get into your pages. Both [Angular](https://angular.io/) and [React](https://reactjs.org/) will do this for you, and they are extremely convenient to use.

You should also implement a [content security policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP) to restrict the domains that content like scripts and stylesheets can be loaded from. Loading content from sites not under your control is a significant security risk, and you should use a CSP to lock this down to only the sources you trust. CSP can also block the use of the `eval()` function.

For content not under your control, consider setting up [sub-resource integrity](https://developer.mozilla.org/en-US/docs/Web/Security/Subresource_Integrity) protection. This allows you to add hashes to stylesheets and scripts you include on your website. Hashes are like fingerprints for digital files; if the content changes, so does the fingerprint. Adding hashes will allow your browser to keep your site safe if the content changes without you knowing.

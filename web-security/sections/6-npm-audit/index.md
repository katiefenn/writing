## npm audit: Protecting yourself from code you don't own
JavaScript and npm run the modern web. Together, they make it easy to take advantage of the world's largest public registry of open source software. How do you protect yourself from code written by someone you've never met? Enter [npm audit](https://blog.npmjs.org/post/173719309445/npm-audit-identify-and-fix-insecure).

npm audit reviews the security of your website's dependency tree. You can start using it by upgrading to the latest version of npm:

```
npm install npm -g
npm audit
```

When you run `npm audit`, npm submits a description of your dependencies to the Registry, which returns a report of known vulnerabilities for the packages you have installed.

![npm audit report](./img/npm-audit-report.png)

If your website has a known cross-site scripting vulnerability, npm audit will tell you about it. What's more, if the vulnerability has been patched, running `npm audit fix` will automatically install the patched package for you!

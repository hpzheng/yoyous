# yoyous
Updated code for yoyous using NGINX and Node.js

## Setting up the server
1. Install NVM (Node Version Manager)
```
curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash
nvm install 0.10
nvm install 4.2.2
node -v
npm -v
```

2. Once node/npm is setup, use NPM to install three other package managers: grunt, bower, and yeoman
```
npm install -g bower
npm install -g yo
npm install -g grunt
npm install -g gulp
```
### Bower is to the web browser what NPM is to Node.js. It is a package manager for your front-end development libraries like jQuery, Bootstrap and so on.
### Yeoman has become the de-facto standard scaffolding toolkit for creating modern JavaScript applications.
### Grunt is automation. It is a task-based command line build tool for JavaScript projects. The official headline: "The JavaScript Task Runner".
### Gulp is the JavaScript task runner newcomer built on top of Node.js streams. It aims at making build scripts easier to use by "preferring code over configuration" (unlike Grunt which is based on configuration).

3. NPM is also used to install other packages, such as CSS preprocessors LESS and SASS
```
npm install -g less
npm install -g sass
```

4. Bower is used to install front-end development libraries and frameworks
```
bower install --save jquery
bower install --save bootstrap
bower install --save font-awesome
bower install --save angularjs
```


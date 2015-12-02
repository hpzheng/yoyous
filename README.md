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

5. Yeoman is used as standard scaffolding toolkit for creating modern JavaScript applications.

6. Grunt is The "JavaScript Task Runner" based on configuration.

7. Gulp is another JavaScript task runner "preferring code over configuration".

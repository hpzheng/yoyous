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
    bower install --save USMap
    bower install --save angularjs
    ```

5. Yeoman is used as standard scaffolding toolkit for creating modern JavaScript applications.

6. Grunt is The "JavaScript Task Runner" based on configuration.
    ```
    npm install -g grunt-cli
    npm install grunt -save-dev
    npm install grunt-contrib-jshint --save-dev
    npm install jshint-stylish --save-dev
    npm install time-grunt --save-dev
    npm install jit-grunt --save-dev

    npm install grunt-contrib-copy --save-dev
    npm install grunt-contrib-clean --save-dev
    npm install grunt-contrib-concat --save-dev
    npm install grunt-contrib-cssmin --save-dev
    npm install grunt-contrib-uglify --save-dev
    npm install grunt-filerev --save-dev
    npm install grunt-usemin --save-dev
    npm install grunt-contrib-watch --save-dev
    npm install grunt-contrib-connect --save-dev
    ```

7. Gulp is another JavaScript task runner "preferring code over configuration".

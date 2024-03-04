# Bitcode

Source for [my Bitcode landing page](http://bitcode.be).

Template: [http://getbootstrap.com/docs/4.0/examples/cover/](http://getbootstrap.com/docs/4.0/examples/cover/)  
Icons: [Iconmnstr](https://iconmonstr.com/)

## Hosting

Site is now hosted on Netlify, dummy. Below is no longer relevant.

## Building

To build the container and push it to Docker hub:

```shell
make build
```

## Deploying

Deploying happens with Docker Machine, a `bitcode` machine has been added locally. 

Make sure that you can execute `deploy.sh`.

```shell
chmod u+x deploy.sh
```

When you want to deploy, execute the script.

```shell
./deploy.sh
```

Why not put these steps in the Makefile, you ask? Because I couldn't figure it out. #dealwithit

## Credits

The idea for this build/deploy flow was taken from [@lucasvanlierop](https://github.com/lucasvanlierop/website/).
A lot of my Docker knowledge comes from [Matthias Noback](https://twitter.com/matthiasnoback).

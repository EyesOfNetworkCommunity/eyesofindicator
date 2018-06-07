## EOI Smashing Alpine Container:  Smashing is the new http://dashing.io fork name. 

Run [Smashing](https://github.com/Smashing/smashing) in a minimal [Alpine](https://alpinelinux.org/about/) [Docker](http://docker.io/) container.

Using alpine image. The container size has been reduced from about 800MB to about 200MB.

## Build (optional)

```git clone https://github.com/EyesOfNetworkCommunity/eyesofindicator```

```cd eyesofindicator```

```docker build -t eyes/eoi:2.0 . ```

## Run
```docker run -d -p 8080:3030 eyes/eoi:2.0```

And point your browser to [http://localhost:8080/](http://localhost:8080/),
or to [http://localhost:8080/sampletv](http://localhost:8080/sampletv) for a 1080p TV layout.


## Configuration
### Custom smashing port
If you want smashing to use a custom port inside the container, e g 8080, use the environment variable `$PORT`:

```docker run -d -e PORT=8080 -p 80:8080 eyes/eoi:2.0```

### Dashboards
To provide a custom dashboard, use container volume **/dashboards**:

```docker run -v=/my/custom/dashboards:/dashboards -d -p 8080:3030 eyes/eoi:2.0```

(*Don't forget to also provide the layout.erb*)

### Jobs
To provide custom jobs, use container volume **/jobs**:

```docker run -v=/my/cool/job:/jobs -d -p 8080:3030 eyes/eoi:2.0```

### Widgets
To install custom widgets supply the gist IDs of the widgets as an environment variable:

```docker run -d -e WIDGETS=5641535 -p 8080:3030 eyes/eoi:2.0```

This example will install the [Random Aww](https://gist.github.com/chelsea/5641535) widget
before starting smashing. Multiple widgets can be supplied.

Also you can use local custom widgets

```docker run -v=/my/cool/widgets:/widgets -d -p 8080:3030 eyes/eoi:2.0```

### Gems
To install gems, supply the gem name(s) as an environment variable:

```docker run -d -e GEMS=instagram -e WIDGETS=5278790 -p 8080:3030 eyes/eoi:2.0```

This example installs the [Instagram photos by location](https://gist.github.com/mjamieson/5278790) widget,
which depends on the instagram gem. Multiple gems and widgets can be supplied like so:

```docker run -d -e GEMS="mysql instagram" -e WIDGETS=5278790 -p 8080:3030 eyes/eoi:2.0```

### Apks
To install apks, supply the apk name(s) as an environment variable:

```docker run -d -e APKS=freetds-dev -e GEMS=tiny_tds -p 8080:3030 eyes/eoi:2.0```

### Public (favicon, 404)
To provide custom 404 and favicon, use container volume **/public**.

### Configuration File
The configuration file ```config.ru``` is available on volume */config*.

Edit this file to change your API key, to add authentication and more.
### lib volume
The smashing lib dir is available on volume */lib-eoi*.

Note: This is a fork of the dockerfile-dashing. Read about that [here](http://github.com/frvi/dockerfile-dashing)

## License
Distributed under the MIT license

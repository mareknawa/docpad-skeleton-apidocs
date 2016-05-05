require('./helpers/objectsPrototypes.js');

#variables used many times in docpad.coffee that can be stored like this
deployment = {
  gulp:
    writeAfter:["replaceApiReferences"]
    generateAfter: ['serviceLatest']
    docpadReady: ['validation_metadata']
  styles: ["/styles/devportal-yaas.css"]
  scripts: ["/scripts/devportal-yaas.min.js"]
  headScripts: ["/scripts/devportal-yaas-head.min.js"]
  apiNotebook: "https://apinotebook.us-east.stage.modules.yaas.io"
  feedbackService: "https://feedback.stage.yaas.io"
  googleAnalytics: (domain) ->
    '<script src="' + domain + '/globalresources/v3/js/yaas.ga.min.js"></script>
     <script>
      $(document).ready(function() {
        sendYaaSAnalytics([
          {
            "id": "UA-56768310-3",
            "name": "devportal"
          },
          {
            "id": "UA-56768310-7",
            "name": "yaas"
          }
        ]);
      });
     </script>'
}

docpadConfig = {

  pluginsPaths: [  # default
        'node_modules'
        'plugins'
    ]

  # =================================
  # Template Data
  # These are variables that will be accessible via our templates
  templateData:

    watchOptions: preferredMethods: ['watchFile','watch']
    # Specify some site properties
    site:

      # Scripts
      headScripts: [
        "/scripts/vendor/jquery-2.1.4.min.js"
        "/scripts/vendor/bootstrap.min.js"
        "/scripts/vendor/select2.min.js"
        "/scripts/vendor/lscache.min.js"
        "/scripts/general/polyfills.js"
        '/scripts/general/jws.min.js'
        '/build/plugins/embed-hash-persistence.js'
      ]


      navPersonalizationScripts: [
        '/scripts/vendor/underscore-min.js'
        '/scripts/custom/packages-names-and-icons.js'
        #'/scripts/custom/listing.js'
      ]

      scripts: [
        "/scripts/general/opt-in-features.js"
        "/scripts/general/modernizr-2.6.2.min.js"
        "/scripts/general/offcanvas.js"
        "/scripts/general/backtop.js"
        "/scripts/general/scrollspy.js"
        "/scripts/general/remember_location.js"
        "/scripts/general/ZeroClipboard-min.js"
        "/scripts/general/expand-collapse.js"
        "/scripts/general/search-bar.js"
        "/scripts/general/code-block.js"
        "/scripts/general/simplePagination.js"
        "/scripts/general/blog.js"
        "/scripts/general/img-click-modal.js"
        "/scripts/general/ZeroClipboard-min.js"
        "/scripts/general/sequence_nav.js"
        "/scripts/general/apiref.js"
        "/scripts/general/left-nav-indicators.js"
        "/scripts/general/replace-svg-images-with-inline-svg.js"
        "/scripts/general/api-filter.js"
        "/scripts/general/api-console.js"
        "/scripts/general/y-factors.js"
        "/scripts/general/ignore-scrolling.js"
      ]


      styles: [
        "/styles/main.css"
        "/styles/components/super-nav.css"
      ]

      # The production url of our website
      url: "http://127.0.0.1:9778"
      yaasUrl: "https://www.stage.yaas.io"
      home: "http://www.yaas.io"

      #redir uri needed for blogging angular app
      redirUri: "http://127.0.0.1:9778/internal/blog/"
      redirBack: "http://127.0.0.1:9778/internal/blog/manage"
      #other stuff for blogging
      oauthService: "https://api.stage.yaas.io/hybris/oauth2/v1"
      accountService: "https://api.stage.yaas.io/hybris/account/v1/"
      packageClientId: "44NwKimthMiKT3BZ9TqfkOjqEf1Gn0Gy"
      productService: "https://api.stage.yaas.io/hybris/product/v1"
      clientId: "7iHzUCcQkcBYrDtIF6N1U0IXTM92RsEu"
      blogFeed: "http://feeds.feedburner.com/yaas/devportalblog-stage"
      internalBlogFeed: "http://feeds.feedburner.com/yaas/internaldevportalblog-stage"
      feedbackService: "http://localhost:8081"
      builderUrl: "https://builder.stage.yaas.io/"
      clientIdListing: "4lfyAwV3zeskWEIzoIMxohRMVYd0YFXI"
      apinotebookService : "http://localhost:3000"
      adminui: "https://builder.stage.yaas.io"
      market: "https://market.stage.yaas.io"
      community: "https://community.stage.yaas.io"
      experts: "https://experts.hybris.com"
      googleAnalytics: () -> ''

      # The default title of our website
      title: "YaaS Dev Portal"

      # The website description (for SEO)
      description: "Dev Portal for SAP Hybris as a Service (yaaS)"

      # The website keywords (for SEO) separated by commas
      keywords: "DevPortal yaaS cloud caas paas"

      # The website author's name
      author: "SAP Hybris"


    # -----------------------------
    # Helper Functions


    # helper used in several placeholders to build navigation links
    # out of service's names or titles. Removes all spaces and special chars


    getApinotebookService: ->
      @site.apinotebookService

    getSiteUrl: ->
      @site.url

    getRedirUri: ->
      @site.redirUri

    getRedirBack: ->
      @site.redirBack

    getProductService: ->
      @site.productService

    getOAuthService: ->
      @site.oauthService

    getAccountService: ->
      @site.accountService

    getApinotebookService: ->
      @site.apinotebookService

    getClientId: ->
      @site.clientId

    getHomeUrl: ->
      @site.home

    getAccountServiceUrl: ->
      @site.account

    getBaaSUrl: ->
      @site.builderUrl

    getMarketUrl: ->
      @site.market

    getYaasUrl: ->
      @site.yaasUrl

    getCommunityUrl: ->
      @site.community

    getTrimmedName: (name) ->
      name.replace(/([^\w-])/g,"")

    #gets a docpad object's relativeDirPath on input
    getVersion: (path, allowedArrayLength) ->
      #need to cut out the version out of the path
      fullPathArray = path.split('/')
      # need to make sure nobody messed up with their
      # docu structure and it is docu/files/flet.html.md
      if !(fullPathArray.length > allowedArrayLength)
        fullPathArray[fullPathArray.length-1]
      else "Version name on last position in the path "+path+" is not char + one or two digits"

    getVersionDigit: (path, allowedArrayLength) ->
      fullPathArray = path.split('/')
      # need to make sure nobody messed up with their
      # docu structure and it is docu/files/flet.html.md
      if !(fullPathArray.length > allowedArrayLength)
        fullVersion = fullPathArray[fullPathArray.length-1]
        #need to get a version number and be ready for 2 digits versions
        if fullVersion.length is 3
          fullVersion.slice(1,3)
        else if fullVersion.length is 2
          fullVersion.slice(1)
      else "Version name on last position in the path "+path+" is not char + one or two digits"

    # Get the prepared site/document title
    # Often we would like to specify particular formatting to our page's title
    # we can apply that formatting here
    getPreparedTitle: ->
      # if we have a document title,
      # then we should use that and suffix the site's title onto it
      if @document.title
        "#{@document.title} | #{@site.title}"
      # if our document does not have it's own title,
      # then we should just use the site's title
      else
        @site.title

    # Get the prepared site/document description
    getPreparedDescription: ->
      # if we have a document description, then we should use that,
      # otherwise use the site's description
      @document.description or @site.description

    # Get the prepared site/document keywords
    getPreparedKeywords: ->
      # Merge the document keywords with the site keywords
      @site.keywords.concat(@document.keywords or []).join(', ')

    trimTo140Char: (content) ->
      if content.length > 140
        content.substr(0, 140) + '...'
      else
        content


  # =================================
  # Collections
  # These are special collections that our website makes available to us

  collections:

    # Get all rn sorted by order meta
    releaseNotes: ->
      @getCollection("documents")
        .findAllLive({url:$startsWith: "/rn"},[filename:-1,service:1])

    # Get all rn sorted by order meta
    apiconsoles: ->
      @getCollection("documents")
        .findAllLive(
          {url:{$startsWith: "/apiconsoles"},
          filename: 'meta-inf'},
          [filename:-1,service:1])

    # Get all rn sorted by order meta
    internalApiConsoles: ->
      @getCollection("documents")
          .findAllLive(
            {url:{$startsWith: "/internal/apiconsoles"},
            filename: 'meta-inf'},
            [filename:-1,service:1])


    # Get all services sorted by order meta
    services: ->
      @getCollection("documents")
        .findAllLive(
          {url:$startsWith: "/services"},
          [order:1,service:1])

    # Get all tools sorted by order meta
    tools: ->
      @getCollection("documents")
        .findAllLive(
          {url:$startsWith: "/tools"},
          [order:1])

    # Get all rn sorted by order meta + paging included
    posts: ->
      @getCollection('html')
        .findAllLive(
          {isPagedAuto:{$ne: true},
          basename:{$nin: ['index', 'release_notes']},
          filename:{$ne: 'meta-inf'},
          url:{$startsWith:"/rn"}},
          [filename:-1]).on "add", (model) ->
            model.setMetaDefaults(layout:"post")

    # Get all tools sorted by order meta
    gettingstarted: ->
      @getCollection("documents")
        .findAllLive(
          {url:$startsWith: "/gettingstarted"},
          [left_nav_area_order:1,left_nav_order:1,order:1])

    internalGettingstarted: ->
      @getCollection("documents")
        .findAllLive(
          {url:$startsWith: "/internal/gettingstarted"},
          [left_nav_area_order:1,left_nav_order:1,order:1])


    overview: ->
      @getCollection("documents")
        .findAllLive(
          {url:$startsWith: "/overview"})

    internalArchitecture: ->
      @getCollection("documents")
        .findAllLive(
          {url:$startsWith: "/internal/architecture/"},
          [order:1])

    # Get all services sorted by order meta
    internalServices: ->
      @getCollection("documents")
        .findAllLive(
          {url:$startsWith:"/internal/services/"},
          [order:1,service:1])

    # Get all services sorted by order meta
    internalTools: ->
      @getCollection("documents")
        .findAllLive({url:$startsWith:"/internal/tools/"},[order:1])

    # Get all general internal docu sorted by order meta
    internalOverview: ->
      @getCollection("documents")
        .findAllLive(
          {url:$startsWith:"/internal/overview/"})

    # Get all general internal docu sorted by order meta
    internalStatuspage: ->
      @getCollection("documents")
      .findAllLive(
        {url:$startsWith:"/internal/statuspage/"})

    # Get all rn sorted by order meta
    internalReleaseNotes: ->
      @getCollection("documents")
      .findAllLive({url:$startsWith: "/internal/rn/"},[filename:-1,service:1])

    # Get all rn sorted by order meta + paging included
    internalPosts: ->
      @getCollection('html')
        .findAllLive(
          {isPagedAuto:{$ne: true},
          basename:{$nin: ['index','release_notes','meta-inf']},
          latest:{$exists:false},
          filename:{$ne: 'internal_atom.xml.eco'},
          url:{$startsWith:"/internal/rn"}},
          [filename:-1]).on "add", (model) ->
            model.setMetaDefaults(layout:"post")

    # Get all internal docs, without sorting yet
    internalDocumentation: ->
      @getCollection('documents').findAllLive({
        url: {$startsWith: '/internal/docu_guide/'}
      })

    # Collections for lunr search collects tools, gettingstarted and api
    searchTools: ->
      @getCollection('html')
        .findAllLive({
          basename:{$ne: 'abstract'},
          extension: {$in:['md', 'html', 'eco']},
          title: {$exists: true},
          url: {$startsWith: "/tools"},
          relativeOutDirPath:{$ne: 'tools'}}).on "add", (model) ->
            model.setMetaDefaults({layout:"tools",result:true})

    searchOverview: ->
      @getCollection('html')
        .findAllLive({
          title: {$exists: true},
          url: {$startsWith: "/overview"},
          relativeOutDirPath:{$ne: 'overview'}}).on "add", (model) ->
            model.setMetaDefaults({layout:"overview",result:true})

    searchServices: ->
      @getCollection('html')
        .findAllLive({
          extension: {$in:['md', 'html', 'eco']},
          title: {$exists: true},
          url: {$startsWith: "/services"},
          relativeOutDirPath:{$ne: 'services'}}).on "add", (model) ->
            model.setMetaDefaults({layout:"document",result:true})

    searchGetStart: ->
      @getCollection('html')
        .findAllLive({
          extension: {$in:['md', 'html', 'eco']},
          title: {$exists: true},
          url: {$startsWith: "/gettingstarted"},
          relativeOutDirPath:{$ne: 'gettingstarted'}}).on "add", (model) ->
            model.setMetaDefaults({layout:"gettingstarted",result:true})

    # Collections for internal lunr search collects tools, gettingstarted and api
    internalSearchTools: ->
      @getCollection('html')
        .findAllLive({
          basename:{$ne: 'abstract'},
          extension: {$in:['eco', 'md', 'html']},
          filename:{$ne: 'release_notes.html.eco'},
          title: {$exists: true},
          url: {$startsWith: "/internal/tools"},
          relativeOutDirPath:{$ne: 'internal/tools'}}).on "add", (model) ->
            model.setMetaDefaults({layout:"tools",result:true})

    internalSearchOverview: ->
      @getCollection('html')
        .findAllLive({
          title: {$exists: true},
          url: {$startsWith: "/internal/overview"},
          relativeOutDirPath:{$ne: 'internal/overview'}}).on "add", (model) ->
            model.setMetaDefaults({layout:"overview",result:true})

    internalSearchServices: ->
      @getCollection('html')
        .findAllLive({
          extension: {$in:['md', 'html', 'eco']},
          title: {$exists: true},
          url: {$startsWith: "/internal/services"},
          relativeOutDirPath:{$ne: 'internal/services'}}).on "add", (model) ->
            model.setMetaDefaults({layout:"document",result:true})

    internalSearchGetStart: ->
      @getCollection('html')
        .findAllLive({
          extension: {$in:['md', 'html', 'eco']},
          title: {$exists: true},
          url: {$startsWith: "/internal/gettingstarted"},
          relativeOutDirPath:{$ne: 'internal/gettingstarted'}}).on "add", (model) ->
            model.setMetaDefaults({layout:"gettingstarted",result:true})

    internalDocuGuideSearch: ->
      @getCollection('html')
        .findAllLive({
          extension: {$in:['md', 'html', 'eco']},
          title: {$exists: true},
          url: {$startsWith: "/internal/docu_guide"},
          relativeOutDirPath:{$ne: 'internal/docu_guide'}}).on "add", (model) ->
            model.setMetaDefaults({layout:"docu_guide",result:true, service:'Documentation Guidelines'})

    internalArchitectureSearch: ->
      @getCollection('html')
        .findAllLive({
          extension: {$in:['md', 'html', 'eco']},
          title: {$exists: true},
          url: {$startsWith: "/internal/architecture"},
          relativeOutDirPath:{$ne: 'internal/architecture'}}).on "add", (model) ->
            model.setMetaDefaults({layout:"architecture",result:true, service:'Architecture'})

  # =================================
  # Plugins

  plugins:

    text:
      matchElementRegexString: 't'

    gulp:
      writeAfter: false #['replaceApiReferences']
      generateAfter: false #['serviceLatest', 'fixTables']
      docpadReady: ['validation_metadata']


    lunr:
      indexes:
        myIndex:
          collection: ['searchOverview',
                      'searchTools',
                      'searchServices',
                      'searchGetStart']
        myInternalIndex:
          collection: ['internalSearchOverview',
                      'internalSearchTools',
                      'internalSearchServices',
                      'internalSearchGetStart',
                      'internalDocuGuideSearch',
                      'internalArchitectureSearch',
                      'searchOverview',
                      'searchTools',
                      'searchServices',
                      'searchGetStart']

  # =================================
  # DocPad Events

  # Here we can define handlers for events that DocPad fires
  # You can find a full listing of events on the DocPad Wiki
  events:

    # Server Extend
    # Used to add our own custom routes
    # to the server before the docpad routes are added
    serverExtend: (opts) ->
      # Extract the server from the options
      {server} = opts
      docpad = @docpad

      server.get /^(\/blog\/)+[^.]+$/, (req, res) ->
        temp = req.url.replace('/blog','')
        res.redirect(req.protocol + '://' + req.get('Host') + '/blog/#' + temp)
      server.get /^(\/internal\/blog\/)+[^.]+$/, (req, res) ->
        temp = req.url.replace('/internal/blog','')
        res.redirect(req.protocol + '://' + req.get('Host') + '/internal/blog/#' + temp)


  # =================================
  #   * Environments
  #

  environments:
    dev:
      templateData:
        site:
          url: "https://devportal-dev.stage.yaas.io"
          redirUri: "https://devportal-dev.stage.yaas.io/internal/blog/"
          redirBack: "https://devportal-dev.stage.yaas.io/internal/blog/manage"
          scripts: deployment.scripts
          headScripts: deployment.headScripts
          styles: deployment.styles
          apinotebookService : deployment.apiNotebook
          feedbackService: deployment.feedbackService

      plugins:
        gulp: deployment.gulp

    stagedev:
      templateData:
        site:
          url: "https://devportal-wookiee.stage.yaas.io"
          redirUri: "https://devportal-wookiee.stage.yaas.io/internal/blog/"
          redirBack: "https://devportal-wookiee.stage.yaas.io/internal/blog/manage"
          scripts: deployment.scripts
          headScripts: deployment.headScripts
          styles: deployment.styles
          apinotebookService : deployment.apiNotebook
          feedbackService: deployment.feedbackService

      plugins:
        gulp: deployment.gulp

    stage_temp:
      templateData:
        site:
          url: "https://devportal-temp.stage.yaas.io"
          account: "https://api.stage.yaas.io/hybris/account/v1/"
          adminui: "https://builder.stage.yaas.io"
          redirUri: "https://devportal-temp.stage.yaas.io/internal/blog/"
          redirBack: "https://devportal-temp.stage.yaas.io/internal/blog/manage"
          scripts: deployment.scripts
          headScripts: deployment.headScripts
          styles: deployment.styles
          apinotebookService : deployment.apiNotebook
          feedbackService: deployment.feedbackService

      plugins:
        gulp: deployment.gulp

    stage_temp_two:
      templateData:
        site:
          url: "https://devportal-temp-two.stage.yaas.io"
          account: "https://api.stage.yaas.io/hybris/account/v1/"
          adminui: "https://builder.stage.yaas.io"
          redirUri: "https://devportal-temp-two.stage.yaas.io/internal/blog/"
          redirBack: "https://devportal-temp-two.stage.yaas.io/internal/blog/manage"
          scripts: deployment.scripts
          headScripts: deployment.headScripts
          styles: deployment.styles
          apinotebookService : deployment.apiNotebook
          feedbackService: deployment.feedbackService

      plugins:
        gulp: deployment.gulp

    prod:
      templateData:
        site:
          url: "https://devportal.yaas.io"
          yaasUrl: "https://www.yaas.io"
          account: "https://api.yaas.io/hybris/account/v1/"
          adminui: "https://builder.yaas.io"
          redirUri: "https://devportal.yaas.io/internal/blog/"
          redirBack: "https://devportal.yaas.io/internal/blog/manage"
          oauthService: "https://api.yaas.io/hybris/oauth2/v1"
          accountService: "https://api.yaas.io/hybris/account/v1/"
          productService: "https://api.yaas.io/hybris/product/v1"
          clientId: "KH5q9P8AhkhAzituxDSO68iR2SmAwvJN"
          blogFeed: "http://feeds.feedburner.com/yaas/devportalblog"
          internalBlogFeed: "http://feeds.feedburner.com/yaas/internaldevportalblog"
          googleAnalytics: deployment.googleAnalytics
          market: "https://market.yaas.io"
          community: "https://community.yaas.io/"
          experts: "https://experts.hybris.com"
          packageClientId: "okkUry41QneQhWUjgk6ObGQikfnzA4fe"
          scripts: deployment.scripts
          headScripts: deployment.headScripts
          styles: deployment.styles
          apinotebookService : "https://apinotebook.us-east.modules.yaas.io"
          feedbackService: "https://feedback.yaas.io"
          builderUrl: "https://builder.yaas.io/"
          clientIdListing: "AhvOOZ7fLGgJu2PUZCOFTLsum0DqFCQH"

      plugins:
        gulp: deployment.gulp


    stage:
      templateData:
        site:
          url: "https://devportal.stage.yaas.io"
          yaasUrl: "https://www.stage.yaas.io"
          account: "https://api.stage.yaas.io/hybris/account/v1/"
          adminui: "https://builder.stage.yaas.io"
          redirUri: "https://devportal.stage.yaas.io/internal/blog/"
          redirBack: "https://devportal.stage.yaas.io/internal/blog/manage"
          scripts: deployment.scripts
          headScripts: deployment.headScripts
          styles: deployment.styles
          apinotebookService : deployment.apiNotebook
          feedbackService: deployment.feedbackService

      plugins:
        gulp: deployment.gulp

}

# Export our DocPad Configuration
module.exports = docpadConfig
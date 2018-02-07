name 'webdeploymenttoolkit'
maintainer 'Patrick McMorran'
maintainer_email 'kingrolloinc@sbcglobal.net'
license 'Unlicense'
description 'Installs/Configures webdeploymenttoolkit'
long_description 'Installs/Configures webdeploymenttoolkit'
version '0.1.10'
issues_url 'https://github.com/wildbillcat-cookbooks/webdeploymenttoolkit/issues'
source_url 'https://github.com/wildbillcat-cookbooks/webdeploymenttoolkit'

depends 'webpi'
supports 'windows'
chef_version '>= 12.7' if respond_to?(:chef_version)

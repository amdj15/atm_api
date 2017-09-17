# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
get 'banknotes/:amount', to: 'v1::banknotes#withdraw'
post 'banknotes', to: 'v1::banknotes#create'

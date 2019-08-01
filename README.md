# Docker Grav CMS
Moddable Container for Grav CMS based on alpine linux

# Usage
This image is meant to be run behind an SSL capable proxy, as it does not care
about transport layer security. It provides a fresh install of grav-admin, 
complete with new-car smell.  

It prioritizes the things I want in a lightweight containerized CMS.  It's small, 
it's moddable, and everything it uses is pretty well-supported.

## Disclaimer
I'm probably not going to maintain this with any real sense of urgency.  You should
probably be able to roll your own updates by incrementing the grav version and 
rebuilding the dockerfile.  If you're not comfortable doing that on your own, maybe
don't use this for anything long-term.
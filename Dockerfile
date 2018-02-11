FROM stilliard/pure-ftpd

# e.g. you could change the default command run:
CMD /usr/sbin/pure-ftpd-virtualchroot -P $PUBLICHOST $ADDED_FLAGS
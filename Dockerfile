FROM jenkins

USER root

RUN apt-get -y update && \
    apt-get install -y php5-cli && \
    apt-get install -y php5-xdebug

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# phpunit
RUN wget https://phar.phpunit.de/phpunit.phar && \
    chmod +x phpunit.phar && \
    mv phpunit.phar /usr/local/bin/phpunit

# phpcs
RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
    chmod +x phpcs.phar && \
    mv phpcs.phar /usr/local/bin/phpcs

# phploc
RUN wget https://phar.phpunit.de/phploc.phar && \
    chmod +x phploc.phar && \
    mv phploc.phar /usr/local/bin/phploc

# pdepend
RUN wget http://static.pdepend.org/php/latest/pdepend.phar && \
    chmod +x pdepend.phar && \
    mv pdepend.phar /usr/local/bin/pdepend

# phpmd
RUN wget https://github.com/phpmd/phpmd/blob/master/src/bin/phpmd && \
    chmod +x phpmd && \
    mv phpmd /usr/local/bin/phpmd

# phpcpd
RUN wget https://phar.phpunit.de/phpcpd.phar && \
    chmod +x phpcpd.phar && \
    mv phpcpd.phar /usr/local/bin/phpcpd

# phpdocx
RUN wget http://phpdox.de/releases/phpdox.phar && \
    chmod +x phpdox.phar && \
    mv phpdox.phar /usr/local/bin/phpdox

USER jenkins
ENV JENKINS_HOME /usr/share/jenkins/ref

COPY plugins/plugins.txt /
RUN /usr/local/bin/plugins.sh /plugins.txt


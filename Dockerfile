FROM ubuntu:22.04
LABEL Author="Peppershade"

# Install necessary packages and dependencies
RUN apt-get update && apt-get install -y \
    supervisor wget libicu-dev tzdata

# Set the timezone
RUN apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Copy supervisord configuration file
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy or install your application
RUN wget https://downloads.smartertools.com/smartermail/beta/100.0.8930.39839/smartermail_8930 && \
    chmod +x smartermail_8930 && \
    ./smartermail_8930 install

# Enable build-in webserver
RUN touch /opt/smartermail/run-webserver.txt

# Change OS information
RUN sed -i 's|PRETTY_NAME="Ubuntu 22.04.4 LTS"|PRETTY_NAME="SmarterMail Docker Ubuntu 22.04.4 LTS"|g' /usr/lib/os-release

# Expose the necessary ports
EXPOSE 80 443 443/udp 587 465 25 990 993 995 110 143 5222

# Add volumes "/opt/smartermail" "/etc/smartermail" "/var/lib/smartermail"
VOLUME ["/opt/smartermail", "/etc/smartermail", "/var/lib/smartermail"]


# Command to run supervisord
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]

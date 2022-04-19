FROM bitnami/spark:3.2.1
# ----------
# Install Livy
# ----------
ENV LIVY_BUILD_VERSION 0.7.1-incubating
ENV LIVY_APP_PATH /opt/bitnami/livy

RUN curl https://www.apache.org/dyn/closer.lua/incubator/livy/$LIVY_BUILD_VERSION/apache-livy-$LIVY_BUILD_VERSION-bin.zip --output /opt/bitnami/livy/apache-livy-$LIVY_BUILD_VERSION-bin.zip



EXPOSE 8998

CMD $LIVY_APP_PATH/bin/livy-server

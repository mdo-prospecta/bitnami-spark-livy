FROM bitnami/spark:3.2.1
LABEL maintainer "Prospecta <developer@prospecta.com>"
USER root

# ----------
# Install Livy
# ----------
ENV LIVY_BUILD_VERSION 0.7.1-incubating
ENV LIVY_PACKAGE apache-livy-$LIVY_BUILD_VERSION-bin
ENV LIVY_HOME /opt/bitnami/livy
ENV LIVY_LOG $LIVY_HOME/logs

RUN install_packages unzip
RUN mkdir -p /apps && \
  cd /apps && \
  curl "https://dlcdn.apache.org/incubator/livy/$LIVY_BUILD_VERSION/apache-livy-$LIVY_BUILD_VERSION-bin.zip" --output /apps/apache-livy-$LIVY_BUILD_VERSION-bin.zip && \
  unzip apache-livy-$LIVY_BUILD_VERSION-bin.zip && \
  rm apache-livy-$LIVY_BUILD_VERSION-bin.zip && \
  mv apache-livy-$LIVY_BUILD_VERSION-bin $LIVY_HOME && \
  mkdir -p $LIVY_LOG && rm -rf /apps

COPY spark-livy-run.sh $LIVY_HOME/bin
RUN chmod g+rwX $LIVY_HOME && chmod g+rwX $LIVY_LOG && chmod +x /opt/bitnami/livy/bin/spark-livy-run.sh

EXPOSE 8998

USER 1001
WORKDIR /opt/bitnami/spark
#ENTRYPOINT ["tail", "-f", "/dev/null"]
ENTRYPOINT [ "/opt/bitnami/scripts/spark/entrypoint.sh" ]
CMD [ "/opt/bitnami/livy/bin/spark-livy-run.sh" ]

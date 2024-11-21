FROM openjdk:11

# Set environment variables
ENV ES_HEAP_SIZE=1g
ENV ES_JAVA_OPTS="-Xms${ES_HEAP_SIZE} -Xmx${ES_HEAP_SIZE}"

# Create a non-root user
RUN useradd -ms /bin/bash elasticsearch

# Download and extract Elasticsearch as the elasticsearch user
RUN wget -O /tmp/elasticsearch.tar.gz https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-8.5.3-linux-x86_64.tar.gz \
    && mkdir /usr/share/elasticsearch \
    && tar -xzf /tmp/elasticsearch.tar.gz -C /usr/share/ \
    && mv /usr/share/elasticsearch-8.5.3 /usr/share/elasticsearch \
    && chown -R elasticsearch:elasticsearch /usr/share/elasticsearch \ # Correct ownership after download
    && rm /tmp/elasticsearch.tar.gz

# Configure Elasticsearch
COPY elasticsearch.yml /usr/share/elasticsearch/config/
RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yml  # Ensure correct ownership of config file


# Expose port
EXPOSE 9200

# Run Elasticsearch as the 'elasticsearch' user
USER elasticsearch
CMD ["/usr/share/elasticsearch/bin/elasticsearch"]
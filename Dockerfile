FROM mongo:4.4.17
 # Will be set through Environment Files
 ARG buildarg_MONGODB_PORT=27017

 ENV URI=mongodb://mongodb:${MONGODB_PORT:-$buildarg_MONGODB_PORT}

 COPY ./copd-assess/copd-assess /copd-assess

 COPY ./copd-careplan-review/copd-careplan-review /copd-careplan-review

 COPY ./hooks_available/cds_services /cds_services

 COPY ./templates/tmr_templates /tmr_templates

 CMD mongoimport  --uri=${URI}/non-cig-db --collection=copd-assess --drop --file=/copd-assess && \
     mongoimport  --uri=${URI}/tmr-db --collection=copd-careplan-review --drop --file=/copd-careplan-review && \
     mongoimport  --uri=${URI}/tmr-db --collection=templates --drop --file=/tmr_templates && \
     mongoimport  --uri=${URI}/cds-services --collection=cds-services --drop --file=/cds_services
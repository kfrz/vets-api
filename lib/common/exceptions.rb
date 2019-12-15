# frozen_string_literal: true

require_dependency 'common/exceptions/base_error'
require_dependency 'common/exceptions/serializable_error'
require_dependency 'common/exceptions/internal/invalid_resource'
require_dependency 'common/exceptions/internal/unknown_format'
require_dependency 'common/exceptions/internal/validation_errors'
require_dependency 'common/exceptions/internal/service_outage'
require_dependency 'common/exceptions/internal/not_a_safe_host_error'
require_dependency 'common/exceptions/internal/record_not_found'
require_dependency 'common/exceptions/internal/invalid_pagination_params'
require_dependency 'common/exceptions/internal/parameter_missing'
require_dependency 'common/exceptions/internal/schema_validation_errors'
require_dependency 'common/exceptions/internal/invalid_field_value'
require_dependency 'common/exceptions/internal/invalid_field'
require_dependency 'common/exceptions/internal/message_authenticity_error'
require_dependency 'common/exceptions/internal/routing_error'
require_dependency 'common/exceptions/internal/invalid_sort_criteria'
require_dependency 'common/exceptions/internal/invalid_filters_syntax'
require_dependency 'common/exceptions/internal/filter_not_allowed'
require_dependency 'common/exceptions/internal/unauthorized'
require_dependency 'common/exceptions/internal/forbidden'
require_dependency 'common/exceptions/internal/unexpected_forbidden'
require_dependency 'common/exceptions/internal/internal_server_error'
require_dependency 'common/exceptions/internal/too_many_requests'
require_dependency 'common/exceptions/external/backend_service_exception'
require_dependency 'common/exceptions/external/service_error'
require_dependency 'common/exceptions/external/resource_not_found'
require_dependency 'common/exceptions/external/gateway_timeout'
require_dependency 'common/exceptions/external/unprocessable_entity'
require_dependency 'common/exceptions/external/bad_gateway'
require_dependency 'common/exceptions/external/bing_service_error'
require_dependency 'common/exceptions/internal/ambiguous_request'
require_dependency 'common/exceptions/internal/token_validation_error'

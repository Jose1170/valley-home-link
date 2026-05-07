json.extract! job_request, :id, :job_title, :job_description, :job_status, :created_at, :updated_at
json.url job_request_url(job_request, format: :json)

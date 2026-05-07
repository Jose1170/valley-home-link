require "test_helper"

class JobRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_request = job_requests(:one)
  end

  test "should get index" do
    get job_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_job_request_url
    assert_response :success
  end

  test "should create job_request" do
    assert_difference("JobRequest.count") do
      post job_requests_url, params: { job_request: { job_description: @job_request.job_description, job_status: @job_request.job_status, job_title: @job_request.job_title } }
    end

    assert_redirected_to job_request_url(JobRequest.last)
  end

  test "should show job_request" do
    get job_request_url(@job_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_request_url(@job_request)
    assert_response :success
  end

  test "should update job_request" do
    patch job_request_url(@job_request), params: { job_request: { job_description: @job_request.job_description, job_status: @job_request.job_status, job_title: @job_request.job_title } }
    assert_redirected_to job_request_url(@job_request)
  end

  test "should destroy job_request" do
    assert_difference("JobRequest.count", -1) do
      delete job_request_url(@job_request)
    end

    assert_redirected_to job_requests_url
  end
end

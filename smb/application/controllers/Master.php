<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, User-ID, Role, Authorization");
header("Access-Control-Allow-Credentials: true");

class Master extends REST_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->helper(['jwt', 'authorization']);
		$this->load->model('AuthModel');
		$this->load->model('MasterModel');
		
		if($this->input->method() != 'options') {
			$res = $this->AuthModel->auth();
			if($res['status'] !== REST_Controller::HTTP_OK)
				$this->response($res, $res['status']);
		}
    }
	
	public function index_options() {
        	return $this->response(NULL, REST_Controller::HTTP_OK);
    	}

	public function route_post($mode)
	{
		$reqBody = file_get_contents("php://input");
		$res = $this->MasterModel->master_post($mode, 'profile_route', json_decode($reqBody, True));
        	$this->response($res, $res['status']);
	}
	
	public function route_get($mode)
	{
		$reqBody = $this->input->get();
		$res = $this->MasterModel->master_get($mode, 'profile_route', $reqBody);
        	$this->response($res, $res['status']);
	}
	
	public function stop_post($mode)
	{
		$reqBody = file_get_contents("php://input");
		$res = $this->MasterModel->master_post($mode, 'profile_stop', json_decode($reqBody, True));
        	$this->response($res, $res['status']);
	}
	
	public function stop_get($mode)
	{
		$reqBody = $this->input->get();
		$res = $this->MasterModel->master_get($mode, 'profile_stop', $reqBody);
        	$this->response($res, $res['status']);
	}
	
	public function maproute_post($mode)
	{
		$reqBody = file_get_contents("php://input");
		$res = $this->MasterModel->master_post($mode, 'map_route_stop', json_decode($reqBody, True));
        	$this->response($res, $res['status']);
	}
	
	
	public function maproute_get($mode)
	{
		$reqBody = $this->input->get();
		$res = $this->MasterModel->master_get($mode, 'map_route_stop', $reqBody);
        	$this->response($res, $res['status']);
	}
	
	public function bus_post($mode)
	{
		$reqBody = file_get_contents("php://input");
		$res = $this->MasterModel->master_post($mode, 'profile_bus', json_decode($reqBody, True));
       		$this->response($res, $res['status']);
	}
	
	
	public function bus_get($mode)
	{
		$reqBody = $this->input->get();
		$res = $this->MasterModel->master_get($mode, 'profile_bus', $reqBody);
        $this->response($res, $res['status']);
	}
	
	public function camera_post($mode)
	{
		$reqBody = file_get_contents("php://input");
		$res = $this->MasterModel->master_post($mode, 'profile_camera', json_decode($reqBody, True));
        	$this->response($res, $res['status']);
	}
	
	
	public function camera_get($mode)
	{
		$reqBody = $this->input->get();
		$res = $this->MasterModel->master_get($mode, 'profile_camera', $reqBody);
        	$this->response($res, $res['status']);
	}
	
	public function student_post($mode)
	{
		$reqBody = file_get_contents("php://input");
		$res = $this->MasterModel->master_post($mode, 'profile_student', json_decode($reqBody, True));
        	$this->response($res, $res['status']);
	}
	
	
	public function student_get($mode)
	{
		$reqBody = $this->input->get();
		$res = $this->MasterModel->master_get($mode, 'profile_student', $reqBody);
        	$this->response($res, $res['status']);
	}

	public function parent_post($mode)
	{
		$reqBody = file_get_contents("php://input");
		$res = $this->MasterModel->master_post($mode, 'profile_parent', json_decode($reqBody, True));
        	$this->response($res, $res['status']);
	}
	
	public function parent_get($mode)
	{
		$reqBody = $this->input->get();
		$res = $this->MasterModel->master_get($mode, 'profile_parent', $reqBody);
       		$this->response($res, $res['status']);
	}

	public function staff_post($mode)
	{
		$reqBody = file_get_contents("php://input");
		$res = $this->MasterModel->master_post($mode, 'profile_staff', json_decode($reqBody, True));
        	$this->response($res, $res['status']);
	}

	public function staff_get($mode)
	{
		$reqBody = $this->input->get();
		$res = $this->MasterModel->master_get($mode, 'profile_staff', $reqBody);
        	$this->response($res, $res['status']);
	}
	public function daily_post($mode)
	{
		$reqBody = file_get_contents("php://input");
		$res = $this->MasterModel->master_post($mode, 'daily_attendance', json_decode($reqBody, True));
        	$this->response($res, $res['status']);
	}

	public function daily_get($mode)
	{
		$reqBody = $this->input->get();
		$res = $this->MasterModel->master_get($mode, 'daily_attendance', $reqBody);
        	$this->response($res, $res['status']);
	}

	public function schedule_post($mode)
	{
		$reqBody = file_get_contents("php://input");
		$res = $this->MasterModel->master_post($mode, 'daily_schedule', json_decode($reqBody, True));
        	$this->response($res, $res['status']);
	}

	public function schedule_get($mode)
	{
		$reqBody = $this->input->get();
		$res = $this->MasterModel->master_get($mode, 'daily_schedule', $reqBody);
        	$this->response($res, $res['status']);
	}



}
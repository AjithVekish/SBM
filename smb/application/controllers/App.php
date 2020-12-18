<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, User-ID, Role, Authorization");
header("Access-Control-Allow-Credentials: true");


class App extends REST_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->helper(['jwt', 'authorization']);
		$this->load->model('AuthModel');
		$this->load->model('AppModel');
		if($this->input->method() != 'options') {
			$res = $this->AuthModel->auth();
			if($res['status'] !== REST_Controller::HTTP_OK)
				$this->response($res, $res['status']);
		}
	}
	public function index_options() {
        	return $this->response(NULL, REST_Controller::HTTP_OK);
    	}

	public function selectedStudents_get()
	{
		$res = $this->AppModel->get_students();
        	$this->response($res, $res['status']);
	}

	public function attendance_get($rfid)
	{
		$res = $this->AppModel->get_attendance($rfid);
        	$this->response($res, $res['status']);
	}

	public function schedule_get()
	{
		$res = $this->AppModel->get_schedule();
        	$this->response($res, $res['status']);
	}


	
}
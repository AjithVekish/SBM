<?php

require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");
header("Access-Control-Allow-Headers: Content-Type, User-ID, Role, Authorization");
header("Access-Control-Allow-Credentials: true");

class Auth extends REST_Controller {
	public function __construct($config = 'rest') {
        	parent::__construct($config);
        	$this->load->helper(['jwt', 'authorization']);
		$this->load->model('AuthModel');
    	}
	
	public function login_post()
	{
		$req = json_decode(file_get_contents("php://input"), True);
		$res = $this->AuthModel->login($req['phone_number'],$req['password']);
        	$this->response($res, $res['status']);
	}
	public function add_post()
	{
		$input = json_decode(file_get_contents("php://input"), True);
		$res = $this->AuthModel->add($input);
        	$this->response($res, $res['status']);
	}
	public function index_options() {
        	return $this->response(NULL, REST_Controller::HTTP_OK);
    	}	
}
/* 
$tokenData = implode("",array_values($input)).date('Hms');
$token = AUTHORIZATION::generateToken($tokenData);
$status = REST_Controller::HTTP_OK;
$response = ['status' => $status, 'token' => $token];
 */
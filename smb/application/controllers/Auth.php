<?php
defined('BASEPATH') OR exit('No direct script access allowed');
require APPPATH . '/libraries/REST_Controller.php';
use Restserver\Libraries\REST_Controller;
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS, PUT, DELETE");

class Auth extends REST_Controller {
	public function __construct() {
        parent::__construct();
        $this->load->helper(['jwt', 'authorization']);
		$this->load->model('AuthModel');
    }
	
	public function login_post()
	{
		$input = $this->input->post();
		$res = $this->AuthModel->login($input['userid'],$input['password'],$input['role']);
        $this->response($res, $res['status']);
	}
	public function add_post()
	{
		$input = $this->input->post();
		$res = $this->AuthModel->add($input);
        $this->response($res, $res['status']);
	}
	
}
/* 
$tokenData = implode("",array_values($input)).date('Hms');
$token = AUTHORIZATION::generateToken($tokenData);
$status = REST_Controller::HTTP_OK;
$response = ['status' => $status, 'token' => $token];
 */
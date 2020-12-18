<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class AuthModel extends CI_Model {
	public $hashKey = 'Basic';
	public function __construct() {
        parent::__construct();
        $this->load->helper(['jwt', 'authorization']);
    }
    public function login($phone_number, $password)
    {	
		$q = $this->db->select('pwd,parent_id AS id,"parent" AS role, img_url, active_student')->from('profile_parent')->where('phone_number',$phone_number)->get()->row();
		if($q == "") {
			$q = $this->db->select('pwd,staff_id AS id, role, img_url, "" AS active_student')->from('profile_staff')->where('phone_number',$phone_number)->get()->row();
		}
		
        if($q == ""){
            return array('status' => 404,'message' => 'Phone number or password mismatched.');
        } else {
            $hashed_password = $q->pwd;
            $id              = $q->id;
            $role              = $q->role;
            $img              = $q->img_url;
	    $active_student = $q->active_student;
			
            if (hash_equals($hashed_password, crypt($password, $this->hashKey))) {
               $last_login = date('Y-m-d H:i:s');
               $token = AUTHORIZATION::generateToken($hashed_password.$id.date("Y-m-d H:i:s"));
               $this->db->trans_start();
               $sql = "INSERT INTO user_auth(user_id, token) VALUES ('".$id."', '".$token."') ON DUPLICATE KEY UPDATE token = VALUES(token)";
               $this->db->query($sql);
               if ($this->db->trans_status() === FALSE){
                  $this->db->trans_rollback();
                  return array('status' => 500,'message' => 'Internal server error.');
               } else {
                  $this->db->trans_commit();
                  return array('status' => 200,'message' => 'Successfully login.','id' => $id, 'role' => $role, 'img' => $img, 'token' => $token, 'active_student' => $active_student);
               }
            } else {
               return array('status' => 204,'message' => 'Wrong password.');
            }
        }
    }
	
	public function logout()
    {
        $users_id  = $this->input->get_request_header('User-ID', TRUE);
        $token     = $this->input->get_request_header('Authorization', TRUE);
        $this->db->where('users_id',$users_id)->where('token',$token)->delete('user_auth');
        return array('status' => 200,'message' => 'Successfully logout.');
    }

    public function signup($userData) {
        
    }
		
	public function auth()
    {
        $users_id  = $this->input->get_request_header('User-ID', TRUE);
        $token     = $this->input->get_request_header('Authorization', TRUE);
        $q  = $this->db->select('token')->from('user_auth')->where('user_id',$users_id)->where('token',$token)->get()->row();
        if($q == ""){
            return array('status' => 401,'message' => 'Unauthorized.');
        } else {
            return array('status' => 200,'message' => 'Authorized.');
        }
    }
}

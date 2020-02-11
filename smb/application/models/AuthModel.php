<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class AuthModel extends CI_Model {
	public $hashKey = 'Basic';
	public function __construct() {
        parent::__construct();
        $this->load->helper(['jwt', 'authorization']);
    }
    public function login($users_id, $password, $role)
    {
		if($role === 'parent') {
			$q  = $this->db->select('pwd,parent_id AS id')->from('profile_parent')->where('parent_id',$users_id)->get()->row();
		}else {
			$q  = $this->db->select('pwd,staff_id AS id')->from('profile_staff')->where('staff_id',$users_id)->get()->row();
		}
        if($q == ""){
            return array('status' => 404,'message' => 'UserID not found.');
        } else {
            $hashed_password = $q->pwd;
            $id              = $q->id;
			
            if (hash_equals($hashed_password, crypt($password, $this->hashKey))) {
               $last_login = date('Y-m-d H:i:s');
               $token = AUTHORIZATION::generateToken($hashed_password.$id.date("Y-m-d H:i:s"));
               $this->db->trans_start();
               $sql = "INSERT INTO user_auth(user_id, token) VALUES ('".$users_id."', '".$token."') ON DUPLICATE KEY UPDATE token = VALUES(token)";
               $this->db->query($sql);
               if ($this->db->trans_status() === FALSE){
                  $this->db->trans_rollback();
                  return array('status' => 500,'message' => 'Internal server error.');
               } else {
                  $this->db->trans_commit();
                  return array('status' => 200,'message' => 'Successfully login.','id' => $id, 'token' => $token);
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

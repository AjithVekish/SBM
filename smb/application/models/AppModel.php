<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class AppModel extends CI_Model {

	public function get_schedule(){
		$userID = $this->input->get_request_header('User-ID', TRUE);
		$retArr = [];
		$sql = "SELECT a.schedule_id, a.bus_id, a.stop_id, a.img_url, a.parent_id, a.start_date, a.end_date, b.bus_name, c.stop_name FROM daily_schedule AS a 
			JOIN profile_bus AS b ON b.bus_id = a.bus_id 
			JOIN profile_stop AS c ON c.stop_id = a.stop_id 
			WHERE a.parent_id = '".$userID."' AND a.state = 0";
		$retArr = $this->db->query($sql)->result_array();
		return array('status' => 200,'message' => 'sucess', 'data' => $retArr); 	                         
	}


	public function get_students(){
		$role = $this->input->get_request_header('Role', TRUE);
		$userID = $this->input->get_request_header('User-ID', TRUE);
		$retArr = [];
		  if($role == 'parent') {
			$q = $this->db->select('active_student')->from('profile_parent')->where('parent_id',$userID)->get()->row();
			$sql = "SELECT student_id, bus_id, stop_id, stop_name, img_url, rfid, full_name FROM profile_student WHERE bus_id != '' AND parent_id = '".$userID."' AND state = 0";
			$retArr = $this->db->query($sql)->result_array();
			return array('status' => 200,'message' => 'sucess', 'active_student' => $q->active_student, 'data' => $retArr); 
		  }else {
			return array('status' => 200,'message' => 'sucess', 'data' => []);
		  }
                        
	}

	public function get_attendance($rfid){
		$retArr = [];
		$where = array('rfid' => $rfid, 'daily_date' => date("Y-m-d"));
		$q = $this->db->select('attendance_id, status')->from('daily_attendance')->where($where)->get()->row();
		if($q != '') {
			$sql = "SELECT time_id, attendance_id, attendance_time, status FROM attendance_time WHERE attendance_id = '".$q->attendance_id."'";
			$retArr = $this->db->query($sql)->result_array();
			return array('status' => 200,'message' => 'sucess', 'currentStatus' => $q->status, 'data' => $retArr);
		} else {
			return array('status' => 201,'message' => 'Student don not have today plan.', 'data' => []);
		}
	}

}
	
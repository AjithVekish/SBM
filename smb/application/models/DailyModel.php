<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class DailyModel extends CI_Model {
	public function attendance_get($rfid) {
		$sql = 'SELECT attendance_id, rfid, student_id, parent_id, ';
		$where = '';
		switch($mode) {
			case 'all':
				$sql = "SELECT * FROM $tblName";
				if(!empty($routeData)) {
					$where = implode(" AND ",array_map(function($k, $v){ return $k." = '".$v."'"; }, array_keys($routeData), $routeData));
					$sql .= " WHERE $where AND state = 0";
				} else {
					$sql .= " WHERE state = 0";
				}
				break;
			case 'filter':
				$clm = $routeData['column'];
				$sql = "SELECT $clm FROM $tblName";
				array_shift($routeData);
				if(!empty($routeData)) {
					$where = implode(" AND ",array_map(function($k, $v){ return $k." = '".$v."'"; }, array_keys($routeData), $routeData));
					$sql .= " WHERE $where AND state = 0";
				} else {
					$sql .= " WHERE state = 0";
				}
				break;
			default:
				$sql = '';
		}
		if($sql == '') return array('status' => 201,'message' => 'Invalid operation.');
		$retArr = $this->db->query($sql)->result_array();
		if ($this->db->trans_status() === FALSE){
			return array('status' => 201,'message' => 'Please check data.');
		} else {
			return array('status' => 200,'message' => ucfirst($mode).' Successfully','data'=> $retArr);			
		}
	}

}

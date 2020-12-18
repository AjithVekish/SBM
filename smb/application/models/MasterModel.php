<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class MasterModel extends CI_Model {

	public function master_post($mode, $tblName, $routeData){
		$sql = '';
		switch($mode) {
			case 'insert':
				$clm = "(".implode(",",array_keys($routeData[0])).")";
				$val = implode(",",array_map(function($v){ return "('".implode("','", $v)."')"; }, array_values($routeData)));
				$sql = "INSERT INTO $tblName $clm VALUES $val";
				break;
			case 'update':
				$clm = "(".implode(",",array_keys($routeData['value'])).")";
				$val =  implode(", ",array_map(function($k, $v){ return $k." = '".$v."'"; }, array_keys($routeData['value']), $routeData['value']));
				$where = implode(" AND ",array_map(function($k, $v){ return $k." = '".$v."'"; }, array_keys($routeData['where']), $routeData['where']));
				$sql = "UPDATE $tblName SET $val WHERE $where";
				break;
			case 'delete':
				if(count($routeData) <= 0) return array('status' => 201,'message' => 'Please send some where data');
				$where = implode(" AND ",array_map(function($k, $v){ return $k." = '".$v."'"; }, array_keys($routeData), $routeData));
				$sql = "DELETE FROM $tblName WHERE $where";
				break;
			case 'img_upload':
				return $this->image_upload($routeData['img'], $tblName, $routeData['id']);
				break;
			default:
				$sql = '';
		}
		if($sql == '') return array('status' => 201,'message' => 'Invalid operation.');
		$this->db->trans_start();
		$this->db->query($sql);
		if ($this->db->trans_status() === FALSE){
			$this->db->trans_rollback();
			return array('status' => 201,'message' => 'Please check data.');
		} else {
			$affectedRows = $this->db->affected_rows();
			$this->db->trans_commit();
			if($affectedRows > 0) return array('status' => 200,'message' => ucfirst($mode).' Successfully');
			else return array('status' => 201,'message' => 'No data affected');
			
		}
    }

	public function master_get($mode, $tblName, $routeData) {
		$sql = '';
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

	public function image_upload($encodeImg = '', $tblName = '', $where = array()) {
		if($encodeImg != '') {
			$image = base64_decode($encodeImg);
			$image_name = md5(uniqid(rand(), true));
			$filename = $image_name . '.' . 'png';
			$path = "./upload/image/".$filename;
			$updatePath = "/upload/image/".$filename;
			file_put_contents($path, $image);
			$where = implode(" AND ",array_map(function($k, $v){ return $k." = '".$v."'"; }, array_keys($where), $where));
			$sql = "UPDATE $tblName SET img_url = '".$updatePath."' WHERE $where";
			$this->db->trans_start();
			$this->db->query($sql);
			if ($this->db->trans_status() === FALSE){
				$this->db->trans_rollback();
				return array('status' => 201,'message' => 'Please check upload image.');
			} else {
				$affectedRows = $this->db->affected_rows();
				$this->db->trans_commit();
				if($affectedRows > 0) return array('status' => 200,'message' => 'Image upload Successfully');
				else return array('status' => 201,'message' => 'Image upload failed');
			}
		}else return array('status' => 200,'message' => 'Parameter missed');
	}
}

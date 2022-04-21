/*
 * @Description:
 * @Author: hongzai
 * @version:
 * @Date: 2022-04-08 12:44:55
 * @LastEditors: hongzai
 * @LastEditTime: 2022-04-08 12:44:55
 */

import { request } from '@/api/service'
export const urlPrefix = '/api/crud_demo/'
export function GetList (query) {
  return request({
    url: urlPrefix,
    method: 'get',
    params: query
  })
}
export function AddObj (obj) {
  return request({
    url: urlPrefix,
    method: 'post',
    data: obj
  })
}
export function UpdateObj (obj) {
  return request({
    url: urlPrefix + obj.id + '/',
    method: 'put',
    data: obj
  })
}
export function DelObj (id) {
  return request({
    url: urlPrefix + id + '/',
    method: 'post',
    params: { id }
  })
}
// 引入axios
import axios from 'axios'
// 请求延时（毫秒数，如果请求话费超过了'timeout'的时间，请求将被中断）
axios.defaults.timeout = 100000
export const getAllData = params => {
  return axios.get('http://localhost:8081/api/projectInfo/GetAll', { params: params });
};

//
//  ErrorMapper.swift
//  NetworkBridge
//
//  Created by Rafat Meraz on 23/1/25.
//

protocol ErrorMapper {
    func mapError(statusCode: Int?, error: Error?) -> ApiError
}

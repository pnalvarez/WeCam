//
//  WCError.swift
//  WeCam
//
//  Created by Pedro Alvarez on 21/03/21.
//  Copyright © 2021 Pedro Alvarez. All rights reserved.
//

import Foundation

enum WCError: Error {
    
    case parseError
    case genericError
    case fetchConnectionsError
    case connectUsersError 
    case signInError
    case unloggedUser
    case createUser
    case saveImage
    case userConnectionError
    case removeConnection
    case removePendingConnection
    case sendConnectionRequest
    case refuseRequest
    case signOut
    case createProject
    case updateUser
    case inviteUserToProject
    case updateProject
    case acceptProjectInvite
    case sendProjectParticipationRequest
    case removeProjectParticipationRequest
    case acceptUserIntoProject
    case removeProjectInviteToUser
    case removeUserFromProject
    case removeSuggestion
    case sendEmail
    case filterProjects
    
    var description: String {
        switch self {
        case .parseError:
            return "Ocorreu um erro"
        case .genericError:
            return "Ocorreu um erro genérico"
        case .unloggedUser:
            return "Ocorreu um erro de autenticação"
        case .fetchConnectionsError:
            return "Ocorreu um erro ao buscar as notificações"
        case .connectUsersError:
            return "Ocorreu um erro ao aceitar a solicitação"
        case .signInError:
            return "Usuário não existente ou senha não correspondente"
        case .createUser:
            return "Ocorreu um erro ao criar o usuário, tente novamente mais tarde"
        case .saveImage:
            return "Ocorreu um erro ao salvar a imagem, tente novamente mais tarde"
        case .userConnectionError:
            return "Ocorreu um erro ao tentar conectar com usuário, tente novamente mais tarde"
        case .removeConnection:
            return "Ocorreu um erro ao tentar remover esta conexão, tente novamente mais tarde"
        case .removePendingConnection:
            return "Ocorreu um erro ao remover essa solicitação, tente novamente mais tarde"
        case .sendConnectionRequest:
            return "Ocorreu um erro ao enviar a solicitação, tente mais tarde"
        case .refuseRequest:
            return "Ocorreu um erro ao recusar a solicitação, tente novamente mais tarde"
        case .signOut:
            return "Erro ao tentar deslogar"
        case .createProject:
            return "Ocorreu um erro ao tentar criar o projeto, tente novamente mais tarde"
        case .updateUser:
            return "Ocorreu um erro ao tentar atualizar as informações deste usuário, tente novamente mais tarde"
        case .inviteUserToProject:
            return "Ocorreu um erro ao convidar o usuário para este projeto, tente novamente mais tarde"
        case .updateProject:
            return "Ocorreu um erro ao tentar atualizar as informações deste projeto, tente novamente mais tarde"
        case .acceptProjectInvite:
            return "Ocorreu um erro ao tentar aceitar a solicitação do usuário neste projeto, tente novamente mais tarde"
        case .sendProjectParticipationRequest:
            return "Ocorreu um erro ao tentar enviar a solicitação a este projeto, tente novamente mais tarde"
        case .acceptUserIntoProject:
            return "Ocorreu um erro ao tentar inserir o usário neste projeto, tente novamente mais tarde"
        case .removeProjectInviteToUser:
            return "Ocorreu um erro ao tentar remover a solicitação a este usuário, tente novamente mais tarde"
        case .removeUserFromProject:
            return "Ocorreu um erro ao tentar remover o usuário deste projeto"
        case .removeSuggestion:
            return "Erro ao tentar remover sugestão"
        case .sendEmail:
            return "Ocorreu um erro ao tentar enviar o email de recuperação, tente novamente mais tarde"
        case .removeProjectParticipationRequest:
            return "Ocorreu um erro ao tentar remover a solicitação a este projeto, tente novamente mais tarde"
        case .filterProjects:
            return "Ocorreu um erro ao filtrar os projetos do feed"
        }
    }
}

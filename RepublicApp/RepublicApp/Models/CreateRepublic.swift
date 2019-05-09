import Foundation
import UIKit

class CreateRepublic : UIViewController {
    
    func validateFields(republicname: String?,acesspassword: String?, confirmacesspassword: String?) -> (Bool,String){
        if let republicname = republicname{
            if let acesspassword = acesspassword, isPasswordValid(password: acesspassword){
                if let confirmacesspassword = confirmacesspassword, acesspassword == confirmacesspassword{
                    return (true,"")
                } else {
                    return (false,"As senhas diferem")
                }
            } else {
                return (false,"Senha tem que possuir 6 digitos")
            }
        } else {
            return (false,"Preencha o campo do nome")
        }
    }
}

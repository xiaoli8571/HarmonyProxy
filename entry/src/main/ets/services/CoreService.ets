import { ProxyService } from './ProxyService'


export class CoreService {


  static startCore(){

    return ProxyService.start()

  }


  static stopCore(){

    return ProxyService.stop()

  }


  static running(){

    return ProxyService.status()

  }


}
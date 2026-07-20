import proxy from 'libentry.so';


export class NativeProxy {


  static start(config:string):boolean {

    return proxy.start(config);

  }



  static stop():boolean {

    return proxy.stop();

  }



  static status():boolean {

    return proxy.status();

  }


}
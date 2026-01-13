# Configuración de Firebase para GCRadar

Este documento contiene las instrucciones paso a paso para configurar Firebase Authentication en tu proyecto iOS.

## Requisitos Previos

- Una cuenta de Google (para acceder a Firebase Console)
- Xcode 14.0 o superior
- iOS 17.0 o superior

## Paso 1: Crear Proyecto en Firebase Console

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Haz clic en "Agregar proyecto" o selecciona un proyecto existente
3. Sigue los pasos del asistente:
   - Ingresa el nombre del proyecto (ej: "GCRadar")
   - Opcionalmente, habilita Google Analytics
   - Crea el proyecto

## Paso 2: Agregar App iOS al Proyecto

1. En la página principal del proyecto, haz clic en el ícono de iOS (🍎)
2. Completa el formulario:
   - **Bundle ID**: Debe coincidir con el Bundle Identifier de tu proyecto Xcode
     - Para encontrarlo: Abre tu proyecto en Xcode → Selecciona el target → Pestaña "General" → "Bundle Identifier"
     - Ejemplo: `com.tudominio.GCRadar`
   - **Nombre de la app**: GCRadar (o el nombre que prefieras)
   - **App Store ID**: Opcional, déjalo vacío por ahora
3. Haz clic en "Registrar app"

## Paso 3: Descargar GoogleService-Info.plist

1. En la siguiente pantalla, Firebase te mostrará un botón para descargar `GoogleService-Info.plist`
2. **IMPORTANTE**: Haz clic en "Descargar GoogleService-Info.plist"
3. Guarda el archivo en un lugar accesible (por ejemplo, el Escritorio)

## Paso 4: Agregar GoogleService-Info.plist al Proyecto Xcode

1. Abre tu proyecto en Xcode
2. En el navegador de archivos (lado izquierdo), haz clic derecho en la carpeta raíz del proyecto (donde está `GCRadarApp.swift`)
3. Selecciona "Add Files to 'GCRadar'..."
4. Navega hasta donde guardaste `GoogleService-Info.plist`
5. **IMPORTANTE**: Asegúrate de que:
   - ✅ "Copy items if needed" esté marcado
   - ✅ El target "GCRadar" esté seleccionado
6. Haz clic en "Add"

## Paso 5: Verificar la Ubicación del Archivo

El archivo `GoogleService-Info.plist` debe estar en la raíz del proyecto, al mismo nivel que:
- `GCRadarApp.swift`
- `ContentView.swift`
- `Assets.xcassets`

## Paso 6: Habilitar Authentication en Firebase Console

1. En Firebase Console, ve a "Authentication" en el menú lateral
2. Haz clic en "Get started"
3. Ve a la pestaña "Sign-in method"
4. Haz clic en "Email/Password"
5. Habilita el primer toggle (Email/Password)
6. Haz clic en "Save"

## Paso 7: Instalar Firebase SDK mediante Swift Package Manager

1. En Xcode, ve a: **File → Add Package Dependencies...**
2. Ingresa la URL: `https://github.com/firebase/firebase-ios-sdk`
3. Selecciona "Up to Next Major Version" y asegúrate de que la versión sea `10.0.0` o superior
4. Haz clic en "Add Package"
5. Selecciona los siguientes productos:
   - ✅ **FirebaseAuth**
   - ✅ **FirebaseCore**
6. Haz clic en "Add Package"

## Paso 8: Verificar la Configuración

1. Abre `GCRadarApp.swift`
2. Verifica que tenga:
   ```swift
   import FirebaseCore
   ```
3. Verifica que en `init()` esté:
   ```swift
   FirebaseApp.configure()
   ```

## Paso 9: Probar la Configuración

1. Ejecuta la app en el simulador o dispositivo
2. Deberías ver la pantalla de Login/Register
3. Intenta crear una cuenta nueva
4. Si todo funciona, verás la pantalla principal después del registro

## Solución de Problemas

### Error: "Could not find GoogleService-Info.plist"
- Verifica que el archivo esté en la raíz del proyecto
- Asegúrate de que esté agregado al target "GCRadar"
- Intenta limpiar el build: **Product → Clean Build Folder** (⇧⌘K)

### Error: "FirebaseApp.configure() failed"
- Verifica que `GoogleService-Info.plist` esté correctamente agregado
- Asegúrate de que el Bundle ID coincida con el de Firebase Console
- Verifica que Firebase SDK esté correctamente instalado

### Error de Autenticación
- Verifica que Email/Password esté habilitado en Firebase Console
- Revisa que el proyecto Firebase esté activo
- Verifica tu conexión a internet

## Recursos Adicionales

- [Documentación oficial de Firebase iOS](https://firebase.google.com/docs/ios/setup)
- [Firebase Authentication Docs](https://firebase.google.com/docs/auth/ios/start)

---

**Nota**: El archivo `GoogleService-Info.plist` contiene información sensible. **NUNCA** lo subas a repositorios públicos de Git. Asegúrate de que esté en tu `.gitignore`.

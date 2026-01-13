# Guía Rápida: Agregar Firebase Firestore

## Pasos Rápidos

### 1. Habilitar Firestore en Firebase Console

1. Ve a [Firebase Console](https://console.firebase.google.com/)
2. Selecciona tu proyecto **GCRadar**
3. En el menú lateral, haz clic en **"Firestore Database"**
4. Si es la primera vez:
   - Haz clic en **"Create database"**
   - Selecciona **"Start in test mode"**
   - Elige una ubicación (ej: `europe-west`)
   - Haz clic en **"Enable"**
5. Ve a la pestaña **"Rules"** y pega estas reglas:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
      
      match /favorites/{favoriteId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

6. Haz clic en **"Publish"**

### 2. Agregar FirebaseFirestore al Proyecto Xcode

#### Opción A: Si ya tienes Firebase instalado

1. En Xcode, ve a: **File → Add Package Dependencies...**
2. En la barra de búsqueda, escribe: `firebase-ios-sdk`
3. Selecciona el paquete existente de Firebase
4. Haz clic en **"Add Package"**
5. En la ventana de selección, marca:
   - ✅ **FirebaseFirestore** (nuevo)
   - ✅ Mantén marcados FirebaseAuth y FirebaseCore
6. Haz clic en **"Add Package"**

#### Opción B: Si es la primera vez instalando Firebase

1. En Xcode, ve a: **File → Add Package Dependencies...**
2. Ingresa la URL: `https://github.com/firebase/firebase-ios-sdk`
3. Selecciona **"Up to Next Major Version"** con versión `10.0.0` o superior
4. Haz clic en **"Add Package"**
5. Selecciona estos productos:
   - ✅ **FirebaseAuth**
   - ✅ **FirebaseCore**
   - ✅ **FirebaseFirestore**
6. Haz clic en **"Add Package"**

### 3. Verificar que Funciona

1. Abre `FavoritesViewModel.swift`
2. Verifica que tenga al inicio:
   ```swift
   import FirebaseAuth
   import FirebaseFirestore
   ```

3. Compila el proyecto: **Product → Build** (⌘B)
4. Si hay errores, limpia el build: **Product → Clean Build Folder** (⇧⌘K)

### 4. Probar la Funcionalidad

1. Ejecuta la app en el simulador
2. Inicia sesión con un usuario
3. Ve a cualquier vista de vuelos (Salidas, Llegadas, etc.)
4. Haz clic en la estrella ⭐ junto a un vuelo para marcarlo como favorito
5. Ve a la pestaña **"Favoritos"** para ver tus vuelos guardados
6. En Firebase Console → Firestore Database → Data, deberías ver:
   ```
   users/
     └── {tu-user-id}/
         └── favorites/
             └── {flight-number}/
                 ├── flightNumber: "IB347"
                 └── createdAt: [timestamp]
   ```

## Solución de Problemas

### ❌ Error: "No such module 'FirebaseFirestore'"

**Solución:**
1. Ve a **File → Packages → Reset Package Caches**
2. Ve a **File → Packages → Resolve Package Versions**
3. Limpia el build: **Product → Clean Build Folder** (⇧⌘K)
4. Cierra y vuelve a abrir Xcode
5. Reconstruye: **Product → Build** (⌘B)

### ❌ Error: "Permission denied" en Firestore

**Solución:**
1. Verifica que las reglas de seguridad estén publicadas en Firebase Console
2. Asegúrate de que el usuario esté autenticado antes de usar favoritos
3. Revisa la consola de Xcode para ver el error específico

### ❌ La app se cierra al intentar guardar favoritos

**Solución:**
1. Verifica que Firestore esté habilitado en Firebase Console
2. Asegúrate de que el usuario esté autenticado
3. Revisa los logs en la consola de Xcode

## Estructura de Datos

Los favoritos se guardan así:

```
users/
  └── {userId}/                    ← UID del usuario autenticado
      └── favorites/
          └── IB347/               ← Número de vuelo normalizado
              ├── flightNumber: "IB347"
              ├── airline: "Iberia" (opcional)
              └── createdAt: Timestamp
```

## ¡Listo! 🎉

Una vez completados estos pasos, tu app debería poder:
- ✅ Guardar vuelos como favoritos
- ✅ Cargar favoritos al iniciar sesión
- ✅ Mostrar favoritos en la vista dedicada
- ✅ Eliminar favoritos

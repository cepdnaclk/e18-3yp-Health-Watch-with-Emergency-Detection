import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, TextInput, View, Button, ImageBackground, TouchableOpacity } from 'react-native';

function sample() { }

export default function App() {
  return (
    <ImageBackground source={require('./assets/bglogo2.jpg')} resizeMode={'cover'} style={styles.backgroundImage}>
      <View style={styles.appContainer}>
        <View style={styles.inputContainer}>
          <TextInput style={styles.textInput} placeholder='Username' />
          <TextInput style={styles.textInput} placeholder='Password' />
          <Text style={styles.textStyle}>Forgot password?</Text>
          <View style={styles.buttonStyle}>
            <TouchableOpacity onPress={sample} style={styles.button}>
              <Text style={styles.buttonText}>LOG IN</Text>
            </TouchableOpacity>
          </View>
          <Text style={{alignSelf: 'center', color: '#ADADAD', paddingTop:8}}>Don't have an account?</Text>
          <View style={styles.buttonStyle}>
            <TouchableOpacity onPress={sample} style={styles.button}>
              <Text style={styles.buttonText}>SIGN UP</Text>
            </TouchableOpacity>
          </View>
          {/* <View style={styles.buttonStyle}>
            <Button style={styles.button} title="Log in" />
          </View> */}
          {/* <View style={styles.buttonStyle}>
            <Button style={styles.button} title="Sign up" />
          </View > */}

        </View>

      </View>
    </ImageBackground>
  );
}

const styles = StyleSheet.create({
  appContainer: {
    flex: 1,
    paddingTop: 250,
    padding: 50,
    alignContent: 'center',
    justifyContent: 'center',

  },

  textStyle: {
    color: '#ADADAD',
    alignSelf: 'flex-end',
  },

  inputContainer: {
    paddingTop: 50,
    padding: 5,
    justifyContent: 'center',
    alignContent: 'center',
  },

  textInput: {
    borderWidth: 1,
    borderColor: '#cccccc',
    wdith: 80,
    height: 40,
    padding: 10,
    marginBottom: 17,
  },

  buttonStyle: {
    marginHorizontal: '6%',
    marginTop: 10,
    marginBottom: 50,
    width: '90%',
    alignContent: 'center',
    justifyContent: 'center',
  },

  backgroundImage: {
    flex: 1,
    resizeMode: 'cover',
    justifyContent: 'center',
    alignContent: 'center',
  },

  button: {
    marginHorizontal: '6%',
    width: '80%',
    height: 40,
    backgroundColor: "#4693FC",
    padding: 10,
    borderRadius: 30
  },

  buttonText: {
    color: "white",
    alignSelf: 'center',
  }

});

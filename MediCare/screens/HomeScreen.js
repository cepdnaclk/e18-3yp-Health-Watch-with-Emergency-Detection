import { StatusBar } from 'expo-status-bar';
import { StyleSheet,Text, Button, View } from 'react-native';

export default function HomeScreen({ navigation }) {
  return ( <>
    <View style={styles.container1}>
        <View style={styles.containerHeader}>
            <Text style={styles.baseParameter}>Hey Anne 👋</Text>
        </View>
        <View style={styles.containerHeader}>
            
        <Button 
            title="Log in screen"
            onPress={() => navigation.navigate("Login", { username: "Anne" })}
        />
        <Button 
            title="2nd: Anne"
            onPress={() => navigation.navigate("Second", { username: "Anne" })}
        />
        <Button 
            title="2nd: David"
            onPress={() => navigation.navigate("Second", { username: "David" })}
        />

        </View>

        
      <StatusBar style="auto" />
    </View>
    <View style={styles.container2}>
        <View style={styles.circle}></View>
    </View>
    
    <View style={styles.container3}>
        <View style={[styles.rectangle1, styles.shadowP]}>
            <View style={styles.rectangle2}><Text style={styles.baseParameter}>Heart Rate</Text></View>
            <View style={styles.rectangle3}><Text>#000</Text></View>
        </View>
        <View style={[styles.rectangle1, styles.shadowP]}>
            <View style={styles.rectangle2}><Text style={styles.baseParameter}>Oxygen level of blood</Text></View>
            <View style={styles.rectangle3}><Text>#000</Text></View>
        </View>
        <View style={[styles.rectangle1, styles.shadowP]}>
            <View style={styles.rectangle2}><Text style={styles.baseParameter}>Temperature</Text></View>
            <View style={styles.rectangle3}><Text>#000</Text></View>
        </View>
        
    </View>
  </>
    
  );
}

const styles = StyleSheet.create({
    
  container1: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'flex-start',
    justifyContent: 'flex-start',
  },

  containerHeader: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'flex-start',
    flexDirection:'row',
    marginLeft:10
  },

  container2: {
    flex: 3,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  container3: {
    flex: 4,
    backgroundColor: '#a2e0ff',
    alignItems: 'center',
    justifyContent: 'center',
  },
  rectangle1: {
    
    backgroundColor: '#3bbaf9',
    alignItems: 'center',
    justifyContent: 'center',
    width:300,
    height:70,
    margin:4,
    borderRadius:10,
    flexDirection: "row",
    
  },
  rectangle2: {
    
    backgroundColor: '#3bbaf9',
    alignItems: 'center',
    justifyContent: 'center',
    width:200,
    height:70,
    margin:4,
    borderRadius:10,
  },

  rectangle3: {
    
    backgroundColor: '#65cbfe',
    alignItems: 'center',
    justifyContent: 'center',
    width:100,
    height:70,
    margin:4,
    borderRadius:10
  },

  baseParameter: {
    fontWeight:'bold',
    fontStyle: 'italic',
    fontSize:17,
    color:"#083c56"
  },
  shadowP: {
    shadowColor: '#171717',
    elevation: 5
  },
  circle:{
    width:200,
    height:200,
    backgroundColor:'#33bbff',
    borderRadius:100
  }

});
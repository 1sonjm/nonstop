package com.nonstop.myapplication;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.design.widget.BottomNavigationView;
import android.support.v7.app.AppCompatActivity;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import android.widget.Toast;

import com.nonstop.myapplication.thread.ChatClientSocketThread;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/*
 *  Android Client Application
 */
public class ChatActivity extends AppCompatActivity {

    ///Field
    // 메세지 좌우배치를 위해 message.xml 를 add 할 Layout
    private LinearLayout messageInLayout;
    private String clientName;
    private Button buttonSend;
    private EditText editTextMessage;
    private ScrollView scrollView;



    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener
            = new BottomNavigationView.OnNavigationItemSelectedListener() {

        @Override
        public boolean onNavigationItemSelected(@NonNull MenuItem item) {
            final Intent[] intent = new Intent[1];
            switch (item.getItemId()) {
                case R.id.navigation_home:
                    intent[0] =new Intent(getBaseContext(),MainActivity.class);
                    startActivity(intent[0]);
                    finish();
                    return true;
                case R.id.navigation_portfolio:
                    intent[0] =new Intent(getBaseContext(),PortfolioActivity.class);
                    startActivity(intent[0]);
                    finish();
                    return true;
                case R.id.navigation_letter:
                    AlertDialog.Builder alt_bld = new AlertDialog.Builder(ChatActivity.this);
                    alt_bld.setMessage("로그아웃 하시겠습니까?").setCancelable(
                            false).setNegativeButton("아니요",
                            new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int id) {
                                    // Action for 'NO' Button
                                    dialog.cancel();
                                }
                            }).setPositiveButton("예",
                            new DialogInterface.OnClickListener() {
                                public void onClick(DialogInterface dialog, int id) {
                                    // Action for 'Yes' Button
                                    SharedPreferences pref = getSharedPreferences("session", MODE_PRIVATE);
                                    SharedPreferences.Editor editor = pref.edit();
                                    editor.remove("user");
                                    editor.commit();
                                    intent[0] =new Intent(getBaseContext(),SessionLogin2Activity.class);
                                    startActivity(intent[0]);
                                    finish();
                                }
                            });
                    AlertDialog alert = alt_bld.create();
                    alert.setTitle("로그아웃");
                    alert.show();
                    return true;
                case R.id.navigation_chat:
                    return false;
            }
            return false;
        }

    };

    private ChatClientSocketThread chatClientSocketThread;

    // Thread / Thread 사이의 통신을 추상화한 Handler Definition
    // - 다른 Thread 가 Message 전달 sendMessage(Message) 호출 시
    // - Looper 가 호출 하는 CallBack Method  handleMessage() O/R
    private Handler handler = new Handler(){

        // Call Back Method Definition
        public void handleMessage(Message message){

            // Application Protocol : 100  ==> 정상

            if(message.what == 100){

                String fromHostData = (String)message.obj;

                append(fromHostData);
/*
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                // 회원유무확인을 위해 변경,추가된부분
                // 대화면 중복인 경우
                //if(fromHostData.indexOf("대화명 중복") != -1){
                // 회원이아닌경우....
                if(fromHostData.indexOf("회원만 입장가능합니다.") != -1){

                    // View 비활성화 시키기
                    buttonSend.setEnabled(false);
                    editTextMessage.setClickable(false);
                    editTextMessage.setEnabled(false);
                    editTextMessage.setFocusable(false);
                    editTextMessage.setFocusableInTouchMode(false);

                    // AlertDialog 이용 현 Activity 종료 , 다른 Activity 로....
                    //new EndAlertDialog(ChatActivity.this)
                    //				.showEndDialogToActivity("[ 대화명중복 ]","대화명 재입력하세요.",LoginActivity.class);
                    new EndAlertDialog(ChatActivity.this)
                            .showEndDialogToActivity("[ 비회원 입니다. ]","회원가입후 사용하세요",LoginActivity.class);
                }
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
*/
                // ScrollView 화면 아래로 이동(두가지 방법)
                //scrollView.scrollTo(0, scrollView.getHeight());
                //scrollView.fullScroll(ScrollView.FOCUS_DOWN);
                //==> 위의 두가지 경우는 .....
                //가장 마지막 줄까지 스크롤 안 될 경우
                //방금 수신 받거나 송신한 메세지의 바로 위 메세지까지 스크롤 될 경우
                //아예 되지 않는 현상이 발생 할 수 있다
                //이는 해당 뷰가 ScrollView에 그려지기 전에 위 코드가 호출 되기 때문이다.
                //==> 아래와 같이 Thread 를 이용 해결
                scrollView.post(new Runnable(){
                    public void run(){
                        scrollView.fullScroll(ScrollView.FOCUS_DOWN);
                    }
                });

                // EditText 전송 Message Delete
                editTextMessage.setText("");

            }

            // Application Protocol : 500  ==> Server 강제종료
            if(message.what == 500){

                String endMessage = (String)message.obj;

                append(endMessage);

                // ScrollView 화면 아래로 이동(두가지 방법)
                //scrollView.scrollTo(0, scrollView.getHeight());
                //scrollView.fullScroll(ScrollView.FOCUS_DOWN);
                scrollView.post(new Runnable(){
                    public void run(){
                        scrollView.fullScroll(ScrollView.FOCUS_DOWN);
                    }
                });

                // View 비활성화
                buttonSend.setEnabled(false);
                editTextMessage.setEnabled(false);
            }
        }
    };


    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.chat);

        // 다른 Activity 에서 호출시 Intent 에 Message 유무를 확인위해
        // Intent instance GET
        Intent intent = this.getIntent();
        SharedPreferences pref = getSharedPreferences("session", MODE_PRIVATE);
        String userSessionJson = pref.getString("user", "");

        JSONParser parser = new JSONParser();
        try {
            String userId = ((JSONObject)parser.parse(userSessionJson)).get("userId").toString();
            System.out.println("로그인된 사람은??????"+userId);
            clientName = userId;

            // Intent 의 Message GET :==> editText View  출력
            //this.clientName = intent.getStringExtra("clientName");
            System.out.println(getClass().getSimpleName()+"::대화명:: "+clientName);

            // 필요한 View GET
            this.scrollView = (ScrollView)findViewById(R.id.scrollview);
            this.messageInLayout = (LinearLayout)findViewById(R.id.message_in_layout);
            this.buttonSend = (Button)findViewById(R.id.button_send);
            this.editTextMessage = (EditText)findViewById(R.id.edittext_message);

            // ChatClientSocketThread 생성 및 Thread.start();
            this.chatClientSocketThread =  new ChatClientSocketThread(handler, clientName);
            chatClientSocketThread.start();

            // 전송 Button Event : 입력 Message Server 전송
            buttonSend.setOnClickListener( new View.OnClickListener() {
                @Override
                public void onClick(View v) {

                    // 대화내용 보내기
                    // Application Protocol
                    // 100 : 대화명입력 / 대화참여
                    // 200 : 모든 대화상대에게 대화내용 보내기
                    // 300 : 특정대상에개 대화내용 보내기
                    // 400 : 대화중단 퇴실
                    chatClientSocketThread.sendMessgeToServer("200:"+editTextMessage.getText());
                }
            });
        } catch (ParseException e) {
            e.printStackTrace();
        }

    }


    public void append(String message){

        //XML  리소스 Inflation 하는 View.inflate()사용 inflate 수행, Root View GET
        LinearLayout messageLayout
                = (LinearLayout) View.inflate	(this, R.layout.message, null);

        // Inflation 된 View 를messageInLayout 에 올리기(?)
        messageInLayout.addView(messageLayout);

        if(message.indexOf(clientName) == -1){
            ( (TextView)  (messageLayout.findViewById(R.id.left_message)) ).setText(message);
            (messageLayout.findViewById(R.id.right_message)).setBackgroundResource(0);
        }else{
            ( (TextView) ( messageLayout.findViewById(R.id.right_message)) ).setText(message);
            ( messageLayout.findViewById(R.id.left_message)).setBackgroundResource(0);
        }
    }


    // Activity Life Cycle 이해
    @Override
    protected void onDestroy() {
        super.onDestroy();

        System.out.println("ChatActivity.onDestory()");

        // 대화종료와 동시에 대화퇴실 전송
        // Application Protocol
        // 100 : 대화명입력 / 대화참여
        // 200 : 모든 대화상대에게 대화내용 보내기
        // 300 : 특정대상에개 대화내용 보내기
        // 400 : 대화중단 퇴실
        chatClientSocketThread.sendMessgeToServer("400:");
        // 경우1 > 서버정상
        // 경우2 > 서버강제종료 경우
        //               : 400 chatClientSocketThread 의 IO null check

        if( chatClientSocketThread != null){
            chatClientSocketThread.onDestroy();
        }
    }

    private long re_PressLimitTime = 2000;
    private long firstPressedTime = 0;
    @Override
    public void onBackPressed() {

        // 종료 EndAlertDialog Bean 사용
        // 다시 취소버튼 누르는 시간
        long tempTime = System.currentTimeMillis();
        long re_PressIntervalTime = tempTime - firstPressedTime;

        System.out.println(0<= re_PressLimitTime && re_PressLimitTime >= re_PressIntervalTime);
        if( 0<= re_PressLimitTime && re_PressLimitTime >= re_PressIntervalTime){
            Intent intent =new Intent(getBaseContext(),MainActivity.class);
            startActivity(intent);
            finish();
        }else{
            firstPressedTime = tempTime;
            Toast.makeText(this, "'취소' 버튼 한번더 누르시면 메인으로 이동합니다. ", Toast.LENGTH_SHORT).show();

        }

    }
}
